qiime diversity alpha-rarefaction --i-table insertion-V24-table-filt_04_09_2020.qza --m-metadata-file Metadata_31_06_20.tsv --i-phylogeny insertion-tree_03_09_2020.qza --o-visualization alpha_V24_visua_fil_04_09_2020 --p-max-depth 2500 --p-metrics "observed_otus" --p-metrics "simpson" --p-metrics  "shannon" --p-metrics "chao1" --p-metrics "simpson_e" --p-metrics  "faith_pd" --p-metrics "pielou_e"