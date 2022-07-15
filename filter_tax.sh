dates=$(date +"%d_%m_%Y")

# Export taxonomy data to tabular format
qiime tools export --output-path taxonomy-export_${dates} --input-path insertion-tax_30_12_2020.qza

# search for matching lines with grep then select the id column
grep -v -i "mitochondria\|Mitochondria\|Chloroplast\|chloroplast\|Feature ID" taxonomy-export_${dates}/taxonomy.tsv | cut  -f 1 > no-chloro-mito-ids_${dates}.txt


# Export data to biom format
qiime tools export --output-path dada2-table-export_${dates} --input-path insertion-V234-table_26_12_2020.qza
# Move into the directory
cd dada2-table-export_${dates}

# Convert the HDF5 biom file to a tsv biom file
biom subset-table \
  --input-hdf5-fp feature-table.biom \
  --axis observation \
  --ids ../no-chloro-mito-ids_${dates}.txt \
  --output-fp feature-table-subset_${dates}.biom

# Create a new QIIME2 data artifact with the filtered Biom file
qiime tools import \
  --input-path feature-table-subset_${dates}.biom \
  --output-path ../insertion-V234-table-filt_${dates}.qza \
  --type FeatureTable[Frequency]

cd ..

#Rarefied the tax table
qiime feature-table rarefy \
  --i-table insertion-V234-table-filt_${dates}.qza \
  --p-sampling-depth 2400 \
  --o-rarefied-table insertion-V234-table-filt_${dates}_rare.qza
  
  #Filter repseqs
  qiime taxa filter-seqs \
  --i-sequences insertion-V234-rep-seqs_${dates}.qza \
  --i-taxonomy insertion-tax_${dates}.qza \
  --p-exclude mitochondria,chloroplast \
  --o-filtered-sequences insertion-V234-filt-rep-seqs_${dates}.qza
