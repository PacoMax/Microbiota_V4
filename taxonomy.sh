#Annotation

dates=$(date +"%d_%m_%Y")

#qiime feature-classifier classify-sklearn --i-classifier /home/fgonzale/fgonzale/databases/gg-13-8-99-515-806-nb-classifier.qza --i-reads Illumina_V4/rep_Illumina_V4_13_09_2020.qza --o-classification tax-v4p_${dates}.qza --p-read-orientation 'same' --p-n-jobs 30


#qiime taxa barplot --i-table Illumina_V4/table_Illumina_V4_13_09_2020.qza --i-taxonomy tax-v4p_${dates}.qza --m-metadata-file Metadata_20_10_20.tsv --o-visualization taxa_barplot_v4p_${dates}.qzv



#qiime feature-classifier classify-sklearn --i-classifier /home/fgonzale/fgonzale/databases/ref-seqs-tain-v12.qza --i-reads Illumina_V2_single/rep_Illumina_V2_single.qza --o-classification tax-v2.qza --p-read-orientation 'same' --p-n-jobs 30

qiime feature-classifier classify-sklearn --i-classifier /home/fgonzale/fgonzale/databases/seqs-train-v34.qza --i-reads Illumina_V4/rep_Illumina_V4* --o-classification tax-v4_${dates}.qza --p-read-orientation 'same' --p-n-jobs 30
qiime taxa barplot --i-table Illumina_V4/table_Illumina_V4_13_09_2020.qza --i-taxonomy tax-v4p_${dates}.qza --m-metadata-file  --o-visualization taxa_barplot_v4p_${dates}.qzv


#qiime feature-classifier classify-sklearn --i-classifier /home/fgonzale/fgonzale/databases/seqs-train-v34.qza --i-reads Illumina_V34/rep_Illumina_V34_15_09_2020_2.qza --o-classification tax-v34_${dates}.qza --p-read-orientation 'same' --p-n-jobs 30


#qiime feature-table merge-taxa --i-data tax-v2.qza --i-data tax-v34_${dates}.qza --i-data tax-v4_${dates}.qza --o-merged-data insertion-tax_${dates}.qza

#Visualization

#qiime feature-table filter-samples --i-table insertion-V234-table-filt_17_09_2020.qza --p-min-frequency 100 --o-filtered-table table_cien_fil_${dates}.qza

#qiime taxa barplot --i-table table_cien_fil_${dates}.qza --i-taxonomy insertion-tax_17_09_2020.qza --m-metadata-file Metadata_16_06_20.tsv --o-visualization taxa_barplot_fil_${dates}.qzv
