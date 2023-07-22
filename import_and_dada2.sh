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
echo "  Usage: `basename $0` [MANIFEST] [cpus] [learn] [region]"
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
               echo  "         interger: 2,3,34,5"
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


folder="Illumina_V${region}"

dates=$(date +"%d_%m_%Y")

qiime tools import --type 'SampleData[SequencesWithQuality]' --input-path $MANIFEST --output-path ${folder}_${dates}.qza --input-format SingleEndFastqManifestPhred33V2


if [ $region == 4 ] || [ $region == 34 ]
        then
        qiime cutadapt trim-single --i-demultiplexed-sequences ${folder}_${dates}.qza --p-front GTGTGYCAGCMGCCGCGGTAA --p-error-rate 0.2 --p-cores $cpus --o-trimmed-sequences trimmed-seqs_${folder}_${dates}.qza --verbose --p-no-discard-untrimmed
        qiime dada2 denoise-single --i-demultiplexed-seqs trimmed-seqs_${folder}_${dates}.qza --p-trunc-len 100 --p-n-threads $cpus --o-table table_${folder}_${dates}.qza --p-n-reads-learn $learn --verbose --o-representative-sequences rep_${folder}_${dates}.qza --o-denoising-stats stats_${folder}_${dates}.qza
else
        qiime dada2 denoise-single --i-demultiplexed-seqs ${folder}_${dates}.qza --p-trunc-len 100 --p-n-threads $cpus --o-table table_${folder}_${dates}.qza --p-n-reads-learn $learn --verbose --o-representative-sequences rep_${folder}_${dates}.qza --o-denoising-stats stats_${folder}_${dates}.qza
fi
