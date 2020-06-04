#!/usr/bin/env bash
if [ "$1" == "-h" ]; then
echo ""
echo "  Welcome to clean_merge.sh"
echo "  These script prepare squences to be processed by V4 single end dada2 pipeline"
echo "  To run this program it's necesary to install these programs:"
echo ""
echo "          trimmomatic"
echo "          prinseq-lite.pl"
echo "          pear"
echo ""
echo "  Usage: `basename $0` [region] [type] [cpu] [ids]"
echo ""
        echo "  region:"
                echo  "         34      : V3-V4 (default)"
                echo  "         4       : V4"
                echo  "         35      : V3-V5"
        echo "  type:"
                echo  "         p       : paired-end"
                echo  "         s       : single-end"
        echo "  cpu:"
                echo  "         interger: number of cpus"
        echo "  ids:"
                echo  "         txt file containing the ids of the runs (file name before .fastq), in case of paired it's only necessary the file name before _1.fastq or _2.fastq"
echo ""
exit 0
fi

region=${1?Error: No region specified. Please, ask for help (clean_merge.sh -h)}
type=${2?Error: No type library specified. Please, ask for help (clean_merge.sh -h)}
cpu=${3?Error: No number of cpus specified. Please, ask for help (clean_merge.sh -h)}
ids=${4?Error: No ids specified. Please, ask for help (clean_merge.sh -h)}

mkdir -p Illumina_V4
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
i=$(wc -l $ids | cut -d ' ' -f 1)
b=1
while [ $b -le 1 ]
do
        samples=$(head -n $i $ids | tail -n $cpu)
        i=$(($i-$cpu))
        for sm in ${samples[*]}
        do
                if [ $region == 4 ] && [ $type == "s" ]
                        then
                        echo "$sm"
                        prinseq-lite.pl -min_qual_mean 20 -trim_qual_window 2 -min_len 100 -trim_qual_right 20 -trim_qual_left 20 -fastq ${sm}* -out_good Illumina_V4/${sm}_good -out_bad null
                fi &
                if [ $region == 34 ] && [ $type == "s" ]
                        then
                        echo "$sm"
                        prinseq-lite.pl -min_qual_mean 20 -trim_left 100 -trim_qual_window 2 -min_len 100 -trim_qual_right 20 -trim_qual_left 20 -fastq ${sm}* -out_good Illumina_V4/${sm}_good -out_bad null
                fi &
                if [ $region == 35 ] && [ $type == "s" ]
                        then
                        echo "$sm"
                        prinseq-lite.pl -min_qual_mean 20 -trim_left 100 -trim_right 50 -trim_qual_window 2 -min_len 100 -trim_qual_right 20 -trim_qual_left 20 -fastq ${sm}* -out_good Illumina_V4/${sm}_good -out_bad null
                fi &
                if [ $region == 4 ] && [ $type == "p" ]
                        then
                        echo "$sm"
                        trimmomatic PE ${sm}_1.fastq ${sm}_2.fastq ${sm}_1_good.fastq ${sm}_1_single_good.fastq ${sm}_2_good.fastq ${sm}_2_single_good.fastq MINLEN:100 LEADING:20 TRAILING:20
                        pear -f ${sm}_1_good.fastq -r ${sm}_2_good.fastq -o $sm -v 10 -m 300 -j 1
                        cat ${sm}.unassembled.forward.fastq ${sm}_1_single_good.fastq ${sm}.assembled.fastq > ${sm}_pre.fastq
                        prinseq-lite.pl -min_qual_mean 20 -min_len 100 -trim_qual_right 20 -trim_qual_left 20 -fastq ${sm}_pre.fastq -out_good Illumina_V4/${sm}_good -out_bad null
                fi &
                if [ $region == 34 ] && [ $type == "p" ]
                        then
                        echo "$sm"
                        trimmomatic PE ${sm}_1.fastq ${sm}_2.fastq ${sm}_1_good.fastq ${sm}_1_single_good.fastq ${sm}_2_good.fastq ${sm}_2_single_good.fastq MINLEN:100 LEADING:20 TRAILING:20
                        pear -f ${sm}_1_good.fastq -r ${sm}_2_good.fastq -o $sm -v 10 -m 300 -j 1
                        cat ${sm}.unassembled.forward.fastq ${sm}_1_single_good.fastq ${sm}.assembled.fastq > ${sm}_pre.fastq
                        prinseq-lite.pl -min_qual_mean 20 -trim_left 100 -min_len 100 -trim_qual_right 20 -trim_qual_left 20 -fastq ${sm}_pre.fastq -out_good Illumina_V4/${sm}_good -out_bad null
                fi &
                if [ $region == 35 ] && [ $type == "p" ]
                        then
                        echo "$sm"
                        trimmomatic PE ${sm}_1.fastq ${sm}_2.fastq ${sm}_1_good.fastq ${sm}_1_single_good.fastq ${sm}_2_good.fastq ${sm}_2_single_good.fastq MINLEN:100 LEADING:20 TRAILING:20
                        pear -f ${sm}_1_good.fastq -r ${sm}_2_good.fastq -o $sm -v 10 -m 300 -j 1
                        cat ${sm}.unassembled.forward.fastq ${sm}_1_single_good.fastq ${sm}.assembled.fastq > ${sm}_pre.fastq
                        prinseq-lite.pl -min_qual_mean 20 -trim_left 100 trim_right 50 -min_len 100 -trim_qual_right 20 -trim_qual_left 20 -fastq ${sm}_pre.fastq -out_good Illumina_V4/${sm}_good -out_bad null
                fi &
                while [ $(jobs -r -p | wc -l) -gt $cpu ]
                do
                sleep 1
                done
        done
        if (($i<$cpu))
                then
                b=2
                fi
done
samples=$(head -n $i $ids | tail -n $cpu)
for sm in ${samples[*]}
do
        if [ $region == 4 ] && [ $type == "s" ]
                then
                echo "$sm"
                prinseq-lite.pl -min_qual_mean 20 -trim_qual_window 2 -min_len 100 -trim_qual_right 20 -trim_qual_left 20 -fastq ${sm}* -out_good Illumina_V4/${sm}_good -out_bad null
        fi &
        if [ $region == 34 ] && [ $type == "s" ]
                then
                echo "$sm"
                prinseq-lite.pl -min_qual_mean 20 -trim_left 100 -trim_qual_window 2 -min_len 100 -trim_qual_right 20 -trim_qual_left 20 -fastq ${sm}* -out_good Illumina_V4/${sm}_good -out_bad null
        fi &
        if [ $region == 35 ] && [ $type == "s" ]
                then
                echo "$sm"
                prinseq-lite.pl -min_qual_mean 20 -trim_left 100 -trim_right 50 -trim_qual_window 2 -min_len 100 -trim_qual_right 20 -trim_qual_left 20 -fastq ${sm}* -out_good Illumina_V4/${sm}_good -out_bad null
        fi &
        if [ $region == 4 ] && [ $type == "p" ]
                then
                echo "$sm"
                trimmomatic PE ${sm}_1.fastq ${sm}_2.fastq ${sm}_1_good.fastq ${sm}_1_single_good.fastq ${sm}_2_good.fastq ${sm}_2_single_good.fastq MINLEN:100 LEADING:20 TRAILING:20
                pear -f ${sm}_1_good.fastq -r ${sm}_2_good.fastq -o $sm -v 10 -m 300 -j 1
                cat ${sm}.unassembled.forward.fastq ${sm}_1_single_good.fastq ${sm}.assembled.fastq > ${sm}_pre.fastq
                prinseq-lite.pl -min_qual_mean 20 -min_len 100 -trim_qual_right 20 -trim_qual_left 20 -fastq ${sm}_pre.fastq -out_good Illumina_V4/${sm}_good -out_bad null
        fi &
        if [ $region == 34 ] && [ $type == "p" ]
                then
                echo "$sm"
                trimmomatic PE ${sm}_1.fastq ${sm}_2.fastq ${sm}_1_good.fastq ${sm}_1_single_good.fastq ${sm}_2_good.fastq ${sm}_2_single_good.fastq MINLEN:100 LEADING:20 TRAILING:20
                pear -f ${sm}_1_good.fastq -r ${sm}_2_good.fastq -o $sm -v 10 -m 300 -j 1
                cat ${sm}.unassembled.forward.fastq ${sm}_1_single_good.fastq ${sm}.assembled.fastq > ${sm}_pre.fastq
                prinseq-lite.pl -min_qual_mean 20 -trim_left 100 -min_len 100 -trim_qual_right 20 -trim_qual_left 20 -fastq ${sm}_pre.fastq -out_good Illumina_V4/${sm}_good -out_bad null
        fi &
        if [ $region == 35 ] && [ $type == "p" ]
                then
                echo "$sm"
                trimmomatic PE ${sm}_1.fastq ${sm}_2.fastq ${sm}_1_good.fastq ${sm}_1_single_good.fastq ${sm}_2_good.fastq ${sm}_2_single_good.fastq MINLEN:100 LEADING:20 TRAILING:20
                pear -f ${sm}_1_good.fastq -r ${sm}_2_good.fastq -o $sm -v 10 -m 300 -j 1
                cat ${sm}.unassembled.forward.fastq ${sm}_1_single_good.fastq ${sm}.assembled.fastq > ${sm}_pre.fastq
                prinseq-lite.pl -min_qual_mean 20 -trim_left 100 -trim_right 50 -min_len 100 -trim_qual_right 20 -trim_qual_left 20 -fastq ${sm}_pre.fastq -out_good Illumina_V4/${sm}_good -out_bad null
        fi &
        while [ $(jobs -r -p | wc -l) -gt $cpu ]
                do
                sleep 1
        done
done
wait
echo "all reads processed"
