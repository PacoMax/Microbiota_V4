mkdir reads #directory where the sequences will be download. 
#option 1
#mkdir ~/ncbi/public/sra #directory where the SRA files wil be download. 
#It will be download in your home. 
#If you need more storage you should make a symbolic link of the folder in your home.
#for i in $(cat SRA.list) #SRA.list is a file containing the SRA IDs
#do
#prefetch $i
#fastq-dump --outdir reads --skip-technical -I -W --split-files ~/ncbi/public/sra/$i.sra
#rm ~/ncbi/public/sra/$i.sra
#sleep 2 #wait 2 sec because of the data traffic
#done
##
#option 2
for i in $(cat ../rivulares) #SRA.list is a file containing the SRA IDs
do
prefetch $i
fastq-dump --outdir reads --skip-technical -I -W --split-files $i/$i.sra
rm -r $i
sleep 2 #wait 2 sec because of the data traffic
done
