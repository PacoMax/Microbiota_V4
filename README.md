# Microbiota_V4
Scripts for analyzing microbiotas using Illumina paired and single end reads containing 16S gene V4 region.

   ### download_sra.sh
   
This script download a list of Sequence Read Archive (SRA) fastq files, available through NCBI servers.

To run this program it's necesary to install the SRA Toolkit and create a txt file with SRA IDs called SRA.list.

      Usage: download_sra.sh

The sequence files will be download in a directory called reads.

   ### clean_and_merge.sh

This script prepare squences to be processed by V4 single end dada2 pipeline

To run this program it's necesary to install these programs:

trimmomatic

prinseq-lite.pl

pear

      Usage: clean_and_merge.sh [region] [type] [cpu] [ids]
  
  region:

    34      : V3-V4 (default)

    4       : V4

    35      : V3-V5

  type:
  
    p       : paired-end
    
    s       : single-end
  
  cpus:
    
    interger: number of cpus
  
  ids:
  
    txt file containing the ids of the runs (file name before .fastq), in case of paired it's only necessary the file name before _1.fastq or _2.fastq
    

   ###  MANIFEST_creator.sh

This script create a MANIFEST file with the sequences from the directory Illumina_V4 created by clean_and_merge.sh

      Usage: MANIFEST_creator.sh

   ### import_and_dada2.sh
   
This script import squences to be processed by dada2 pipeline.

To run this program it's necesary to activate qiime2 enviroment.

This pipeline cut all the reads to 100 bp length.

To change that, you can edit this script with a text editor in the option --p-trunc-len (default 100bp).

      Usage: import_and_dada2.sh [MANIFEST] [cpus] [learn]"

   MANIFEST:
      
               txt two columns tab separated file which should look like:
               
               sample-id   absolute-filepath
               
               {ID}  {path}/Illumina_V4/{ID}_good.fastq
               
   cpus:
      
               interger: number of cpus

   learn:
      
               interger: number of reads for the dada2 learning algorith default choose 1000000
