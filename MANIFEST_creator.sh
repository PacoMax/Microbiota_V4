#!/usr/bin/env bash
#This script creates a MANIFEST file with the sequences from the directory Illumina_V{n} created by clean_and_merge.sh
dir=$(pwd)/Illumina_*/
list_seq=$(ls Illumina_V*| grep "_good.fastq$" | sed 's/_good.fastq$//g')
dates=$(date +"%d_%m_%Y")
touch Illumina_V*/MANIFEST_${dates}.txt
echo "sample-id absolute-filepath" >> Illumina_V*/MANIFEST_${dates}.txt
for i in $list_seq; do echo "$i ${dir}/${i}_good.fastq" >> Illumina_V4/MANIFEST_${dates}.txt; done
