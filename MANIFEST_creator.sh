#This script create a MANIFEST file with the sequences from the directory Illumina_V4 created by clean_and_merge.sh
dir=$(pwd)/Illumina_V4/
list_seq=$(ls Illumina_V4| grep "_good.fastq" | sed 's/_good.fastq$//g')
dates=$(date +"%d_%m_%Y")
touch Illumina_V4/MANIFEST_${dates}.txt
echo "sample-id absolute-filepath" >> Illumina_V4/MANIFEST_${dates}.txt
for i in $list_seq; do echo "$i ${dir}${i}_good.fastq" >> Illumina_V4/MANIFEST_${dates}.txt; done
