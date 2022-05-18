mkdir reads #directory where the sequences will be download. 
for i in $(cat SRA.list) #SRA.list is a file containing the SRA IDs
do
prefetch $i -O $i
fastq-dump --outdir reads --skip-technical -I -W --split-files $i/$i.sra
rm -r $i
sleep 2 #wait 2 sec because of the data traffic
done
