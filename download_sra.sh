mkdir reads #directory where the sequences will be download. 
mkdir ncbi/public/sra #directory where the SRA files wil be download.
for i in $(cat SRA.list) #SRA.list is a file containing the SRA IDs
do
prefetch -v $i
fastq-dump --outdir reads --skip-technical -I -W --split-files ncbi/
public/sra/$i.sra
rm ncbi/public/sra/$i.sra
sleep 2 #wait 2 sec because of the data traffic
done