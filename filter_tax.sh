#This script eliminates chloroplast and mitrochondrial sequences 

# Export taxonomy data to tabular format
qiime tools export --output-path taxonomy-export --input-path insertion-tax.qza

# search for matching lines with grep then select the id column
grep -v -i "mitochondia\|Chloroplast\|Feature ID" taxonomy-export/taxonomy.tsv | cut  -f 1 > no-chloro-mito-ids.txt


# Export data to biom format
qiime tools export --output-path dada2-table-export --input-path insertion-V24-table.qza
# Move into the directory
cd dada2-table-export

# Convert the HDF5 biom file to a tsv biom file
biom subset-table \
  --input-hdf5-fp feature-table.biom \
  --axis observation \
  --ids ../no-chloro-mito-ids.txt \
  --output-fp feature-table-subset.biom

# Create a new QIIME2 data artifact with the filtered Biom file
qiime tools import \
  --input-path feature-table-subset.biom \
  --output-path ../insertion-V24-table-filt.qza \
  --type FeatureTable[Frequency]

cd ..
