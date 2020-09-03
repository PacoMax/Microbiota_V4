#Annotation

dates=$(date +"%d_%m_%Y")                                                                                                                                                                                                                    
#qiime feature-classifier classify-sklearn --i-classifier /home/fgonzale/fgonzale/databases/ref-seqs-tain-v12.qza --i-reads Illumina_V2_single/rep_Illumina_V2_single.qza --o-classification tax-v2.qza --p-read-orientation 'same' --p-n-jo$
qiime feature-classifier classify-sklearn --i-classifier /home/fgonzale/fgonzale/databases/seqs-train-v34.qza --i-reads Illumina_V4/rep_Illumina_V4_03_09_2020.qza --o-classification tax-v4_${dates}.qza --p-read-orientation 'same' --p-n-$

qiime feature-table merge-taxa --i-data tax-v2.qza --i-data tax-v4_${dates}.qza --o-merged-data insertion-tax_${dates}.qza

#Visualization

#qiime feature-table filter-samples --i-table insertion-V24-table.qza --p-min-frequency 100 --o-filtered-table table_cien_fil.qza

#qiime taxa barplot --i-table table_cien_fil.qza --i-taxonomy insertion-tax.qza --m-metadata-file metadata_v1_08_07_20.tsv --o-visualization taxa_barplot_fil.qzv
