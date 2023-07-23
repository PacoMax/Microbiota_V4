
#Downloading RDP
wget http://rdp.cme.msu.edu/download/current_Bacteria_unaligned.fa.gz .
#Extracting the RDP sequences
zcat current_Bacteria_unaligned.fa.gz | sed 's/\(>\w\+\)\s.*/\1/g' | sed 's/\(.*\)/\U\1/' > RDP.fa
#Importing RDP sequences
qiime tools import --type 'FeatureData[Sequence]' --input-path RDP.fa --output-path RDP.qza

#Creating RDP_tax_id.txt
#zgrep ">" current_Bacteria_unaligned.fa.gz | sed 's/\t/\n/g' | sed 's/\(>\w\+\)\s.*/\1/g' | sed 's/domain;//g' |sed 's/phylum;//g' | sed 's/subclass;//g' | sed 's/class;//g' | sed 's/suborder;//g' | sed 's/order;//g' | sed 's/family;//g' | sed 's/genus//g'  | tr '\n' '\t' | sed 's/Lineage=Root;rootrank;//g' | sed 's/;/; /g' | sed 's/>/\n>/g' | sed '/^$/d' | sed 's/"//g' | sed 's/>//g' | sed 's/\t/#/g' | sed 's/\s//g' | sed 's/#/\t/g' > RDP_tax_id.txt
zgrep ">" current_Bacteria_unaligned.fa.gz | sed 's/\t/\n/g' | sed 's/"//g'| sed 's/\(>\w\+\)\s.*/\1/g' | sed 's/domain;//g' |sed 's/phylum;//g' | sed 's/;\w\+;subclass;/;/g' | sed 's/class;//g' | sed 's/;\w\+;suborder;/;/g' | sed 's/order;//g' | sed 's/family;//g' | sed 's/genus//g'  | tr '\n' '\t' | sed 's/Lineage=Root;rootrank;//g' | sed 's/;/; /g' | sed 's/>/\n>/g' | sed '/^$/d' | sed 's/>//g' | sed 's/\t/#/g' | sed 's/\s//g' | sed 's/#/\t/g' > RDP_tax_id.txt


#import IDs
qiime tools import --type 'FeatureData[Taxonomy]' --input-format HeaderlessTSVTaxonomyFormat --input-path RDP_tax_id.txt --output-path RDP_tax_id.qza

#Cut regions
qiime feature-classifier extract-reads --i-sequences RDP.qza --p-n-jobs 15 --p-f-primer AGAGTTTGATYMTGGCTCAG --p-r-primer TGCTGCCTCCCGTAGGAGT --p-trunc-len 349 --o-reads ref-seqs-v2.qza
qiime feature-classifier extract-reads --i-sequences RDP.qza --p-n-jobs 15 --p-f-primer CCTACGGGNGGCWGCAG --p-r-primer GGACTACNVGGGTWTCTAAT --p-trunc-len 466 --o-reads ref-seqs-v34.qza
qiime feature-classifier extract-reads --i-sequences RDP.qza --p-n-jobs 15  --p-f-primer CACGGTCGKCGGCGCCATT --p-r-primer GGACTACHVGGGTWTCTAAT --p-trunc-len 466 --o-reads ref-seqs-v4.qza

#Trining the classifier
qiime feature-classifier fit-classifier-naive-bayes --i-reference-reads ref-seqs-v2.qza --i-reference-taxonomy RDP_tax_id.qza --o-classifier ref-seqs-tain-v2.qza
qiime feature-classifier fit-classifier-naive-bayes --i-reference-reads ref-seqs-v4.qza --i-reference-taxonomy RDP_tax_id.qza --o-classifier ref-seqs-tain-v4.qza
qiime feature-classifier fit-classifier-naive-bayes --i-reference-reads ref-seqs-v34.qza --i-reference-taxonomy RDP_tax_id.qza --o-classifier ref-seqs-tain-v34.qza
