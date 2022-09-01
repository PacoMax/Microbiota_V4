mkdir collapse
for i in {1..7}
do
qiime taxa collapse \
    --i-table insertion-V234-table-filt_26_07_2022_rare.qza \
    --i-taxonomy insertion-tax_26_07_2022.qza \
    --p-level $i \
    --o-collapsed-table collapse/table-L${i}_8_8_22.qza
qiime tools export --input-path collapse/table-L${i}_8_8_22.qza --output-path collapse/table-L${i}_8_8_22
biom convert -i collapse/table-L${i}_8_8_22/feature-table.biom -o collapse/table-L${i}_8_8_22.txt --to-tsv
done
