for i in $(cat PATHs_Illumina); #PATHS_Illumina are the paths of the Illumina_Vn directory created by clean_and_merge.sh
do
cd $i;
MANIFEST_creator.sh;
done
