dates=$(date +"%d_%m_%Y")

export LC_ALL=en_US.utf-8 #two lines for ASQII phyton issues
export LANG=en_US.utf-8


qiime feature-table merge-seqs --i-data Illumina_V2_single/rep_Illumina_V2_single.qza --i-data Illumina_V4/rep_Illumina_V4_09_07_2020.qza --o-merged-data insertion-rep-seqs_${dates}.qza

#download silva tree
qiime fragment-insertion sepp --i-representative-sequences insertion-rep-seqs_${dates}.qza --p-threads 12 --o-tree insertion-tree_${dates}.qza --i-reference-database sepp-refs-silva-128.qza --o-placements insertion-placements_${dates}.qza
