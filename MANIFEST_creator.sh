#!/usr/bin/env bash
#This script creates a MANIFEST file with the sequences from the directory Illumina_V{n} created by clean_and_merge.sh
dir=$(pwd)
list_seq=$(ls | grep "_good.fastq$" | sed 's/_good.fastq$//g')
dates=$(date +"%d_%m_%Y")
touch MANIFEST_${dates}.txt
echo "sample-id absolute-filepath" >> MANIFEST_${dates}.txt
for i in $list_seq; do echo "$i ${dir}/${i}_good.fastq" >> MANIFEST_${dates}.txt; done
