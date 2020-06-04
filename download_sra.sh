mkdir reads
mkdir ncbi/public/sra
for i in $(cat SRA.list)
do
prefetch -v $i
fastq-dump --outdir  reads --skip-technical -I -W --split-files ncbi/
public/sra/$i.sra
rm ncbi/public/sra/$i.sra
sleep 2 #wait 2 sec because of the data traffic
done
