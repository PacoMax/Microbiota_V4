#This is a particular script for Salamanders project


export LC_ALL=en_US.utf-8 #two lines for ASQII phyton issues 
export LANG=en_US.utf-8
source activate qiime2-2019.10 #activate the envieroment where is qiime2


#MANIFEST_ae should look like:
##sample-id       absolute-filepath
#38B2    {path}/Illumina_V4/38B2_good.fastq

qiime tools import --type 'SampleData[SequencesWithQuality]' --input-path MANIFEST_ae --output-path Illumina_V4_ae.qza --input-format SingleEndFastqManifestPhred33V2
qiime dada2 denoise-single --i-demultiplexed-seqs Illumina_V4_ae.qza --p-trunc-len 100 --p-n-threads 20 --o-table table_Illumina_V4_ae_100.qza --p-n-reads-learn 3000000 --p-max-ee 200 --verbose --o-representative-sequences rep_Illumina_V
4_ae_100.qza --o-denoising-stats stats_Illumina_V4_ae_100.qza
qiime dada2 denoise-single --i-demultiplexed-seqs Illumina_V4_ae.qza --p-trunc-len 0 --p-n-threads 20 --o-table table_Illumina_V4_ae.qza --p-n-reads-learn 3000000 --p-max-ee 200 --verbose --o-representative-sequences rep_Illumina_V4_ae.q
za --o-denoising-stats stats_Illumina_V4_ae.qza
