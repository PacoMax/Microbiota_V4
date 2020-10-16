#!/usr/bin/env bash
if [ "$1" == "-h" ]; then
echo ""
echo "  Welcome to import_and_dada2.sh"
echo "  This script import squences to be processed by dada2 pipeline"
echo "  To run this program it's necesary to activate qiime2 enviroment"
echo ""
echo "    This pipeline cut all the reads to 100 bp length"
echo "    To change that, you can edit this script with a text editor in the option --p-trunc-len (default 100bp)"
echo ""
echo "  Usage: `basename $0` [MANIFEST] [cpus] [learn] [rare] [region]"
echo ""
echo "  MANIFEST:"
               echo "         txt file which should look like:"
               echo "         sample-id       absolute-filepath"
               echo "         {id} {path}/{id}_good.fastq"
echo ""
echo "  cpus:"
               echo  "         interger: number of cpus"
echo ""
echo "  learn:"
               echo  "         interger: number of reads for the dada2 learning algorith default choose 1000000"
echo ""
echo ""
echo "  rare:"
               echo  "         interger: maximum rarefaction size"
echo ""
echo "  region:"
               echo  "         interger: 4 or 34"
echo ""




exit 0
fi
MANIFEST=${1?Error: No MANIFEST specified. Please, ask for help (./import_and_dada2.sh -h)}
cpus=${2?Error: No number of cpus specified. Please, ask for help (./import_and_dada2.sh -h)}
learn=${3?Error: No number of reads for the dada2 learning algorith, choose default 1000000}
rare=${4?Error: No number of rarefaction size set,Please, ask for help (./import_and_dada2.sh -h)}
region=${5?Error: No region specified,Please, ask for help (./import_and_dada2.sh -h)}



export LC_ALL=en_US.utf-8 #two lines for ASQII phyton issues
export LANG=en_US.utf-8

#source activate qiime2-2019.10

folder="Illumina_V${region}"

dates=$(date +"%d_%m_%Y")

qiime tools import --type 'SampleData[SequencesWithQuality]' --input-path $MANIFEST --output-path ${folder}/${folder}_${dates}.qza --input-format SingleEndFastqManifestPhred33V2


if [ $region == 34 ]
        then
       qiime cutadapt trim-single --i-demultiplexed-sequences ${folder}/${folder}_${dates}.qza --p-front GTGTGYCAGCMGCCGCGGTAA --p-error-rate 0.2 --p-cores $cpus --o-trimmed-sequences ${folder}/trimmed-seqs_${folder}_${dates}.qza --verb
ose --p-discard-untrimmed


        ##grepiar
       unzip -o ${folder}/trimmed-seqs_${folder}_${dates}.qza -d ${folder}/trimmed-seqs_${folder}_${dates}
       ls ${folder}/trimmed-seqs_${folder}_${dates}/*/data/ | grep "fastq.gz" > lista_${dates}
       for i in $(cat lista_${dates}); do zgrep "@${i%_*_*_*_*.fastq.gz}" ${folder}/trimmed-seqs_${folder}_${dates}/*/data/${i} > tmp_head; LC_ALL=C fgrep -A3 -f tmp_head ${folder}/${i%_*_*_*_*.fastq.gz}_good.fastq | sed '/^--$/d' > ${f
older}/${i%_*_*_*_*.fastq.gz}_good_2.fastq; done


       sed 's/_good.fastq/_good_2.fastq/g' $MANIFEST > MANIFEST_2_${dates}

       qiime tools import --type 'SampleData[SequencesWithQuality]' --input-path MANIFEST_2_${dates} --output-path ${folder}/${folder}_${dates}_2.qza --input-format SingleEndFastqManifestPhred33V2


        qiime dada2 denoise-single --i-demultiplexed-seqs ${folder}/${folder}_${dates}_2.qza --p-trim-left 100 --p-trunc-len 0 --p-n-threads $cpus --o-table ${folder}/table_${folder}_${dates}_2.qza --p-n-reads-learn $learn --p-max-ee $ra
re --verbose --o-representative-sequences ${folder}/rep_${folder}_${dates}_2.qza --o-denoising-stats ${folder}/stats_${folder}_${dates}_2.qza

fi

if [ $region == 4]
        then

        qiime cutadapt trim-single --i-demultiplexed-sequences ${folder}/${folder}_${dates}.qza --p-front GTGTGYCAGCMGCCGCGGTAA --p-error-rate 0.2 --p-cores $cpus --o-trimmed-sequences ${folder}/trimmed-seqs_${folder}_${dates}.qza --verb
ose p-no-discard-untrimmed


        qiime dada2 denoise-single --i-demultiplexed-seqs ${folder}/trimmed-seqs_${folder}_${dates}.qza --p-trunc-len 100 --p-n-threads $cpus --o-table ${folder}/table_${folder}_${dates}.qza --p-n-reads-learn $learn --p-max-ee $rare --ve
rbose --o-representative-sequences ${folder}/rep_${folder}_${dates}.qza --o-denoising-stats ${folder}/stats_${folder}_${dates}.qza

fi
