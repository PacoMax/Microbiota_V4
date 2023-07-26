mkdir collapse
for i in {1..7}
do
qiime taxa collapse \
    --i-table insertion-V234-table-filt_*.qza \
    --i-taxonomy ../insertion-tax_*.qza \
    --p-level $i \
    --o-collapsed-table collapse/table-L${i}.qza
qiime tools export --input-path collapse/table-L${i}.qza --output-path collapse/table-L${i}
biom convert -i collapse/table-L${i}/feature-table.biom -o collapse/table-L${i}.txt --to-tsv
done
