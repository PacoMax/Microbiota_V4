#This is a particular script for Salamanders project


export LC_ALL=en_US.utf-8 #two lines for ASQII phyton issues 
export LANG=en_US.utf-8
source activate qiime2-2019.10 #activate the envieroment where is qiime2

qiime alignment mafft --i-sequences rep_Illumina_V4.qza --p-n-threads 12 --o-alignment aligned-rep_Illumina_V4.qza
qiime alignment mask --i-alignment aligned-rep_Illumina_V4.qza --o-masked-alignment masked-aligned-rep_Illumina_V4.qza
qiime phylogeny fasttree --i-alignment masked-aligned-rep_Illumina_V4.qza --p-n-threads 12 --o-tree unrooted-tree-v4.qza
qiime phylogeny midpoint-root --i-tree unrooted-tree-v4.qza --o-rooted-tree rooted-tree-v4.qza
