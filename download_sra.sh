#It works with sra toolkit.3.0.0
#Installation
#wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/3.0.0/sratoolkit.3.0.0-ubuntu64.tar.gz
# tar -vxzf sratoolkit.3.0.0-ubuntu64.tar.gz
# add to the PATH
# export PATH=$PATH:$PWD/sratoolkit.3.0.0-mac64/bin
# configure
# vdb-config --interactive
mkdir reads #directory where the sequences will be download.
for i in $(cat SRA.list) #SRA.list is a file containing the SRA IDs
#Example:
#Look file SRA.list
do
prefetch $i -o $i.sra
fastq-dump --outdir reads --skip-technical -I -W --split-files $i.sra
rm -r $i.sra
sleep 2 #wait 2 sec because of the data traffic
done
