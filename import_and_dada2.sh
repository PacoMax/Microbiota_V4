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
echo "  Usage: `basename $0` [MANIFEST] [cpus] [learn]"
echo ""
echo "  MANIFEST:"
               echo "         txt file which should look like:"
               echo "         sample-id       absolute-filepath"
               echo "         {ID} {path}/Illumina_V4/{ID}_good.fastq"
echo ""       
echo "  cpus:"
               echo  "         interger: number of cpus"
echo ""      
echo "  learn:"
               echo  "         interger: number of reads for the dada2 learning algorith default choose 1000000"
echo ""
exit 0
fi
MANIFEST=${1?Error: No MANIFEST specified. Please, ask for help (./import_and_dada2.sh -h)}
cpus=${2?Error: No number of cpus specified. Please, ask for help (./import_and_dada2.sh -h)}
learn=${3?Error: No number of reads for the dada2 learning algorith, choose default 1000000}

export LC_ALL=en_US.utf-8 #two lines for ASQII phyton issues 
export LANG=en_US.utf-8

dates=$(date +"%d_%m_%Y")

qiime tools import --type 'SampleData[SequencesWithQuality]' --input-path $MANIFEST --output-path Illumina_V4/Illumina_V4_${date}.qza --input-format SingleEndFastqManifestPhred33V2
qiime dada2 denoise-single --i-demultiplexed-seqs Illumina_V4/Illumina_V4_${date}.qza --p-trunc-len 100 --p-n-threads 20 --o-table Illumina_V4/table_Illumina_V4_${date}.qza --p-n-reads-learn $learn --p-max-ee 200 --verbose --o-representative-sequences Illumina_V4/rep_Illumina_V
4_${date}.qza --o-denoising-stats Illumina_V4/stats_Illumina_V4_${date}.qza
