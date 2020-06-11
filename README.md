# Skin_microbiome_salamander
Scripts for analyzing skin microbiota from salamanders arround the world

##clean_and_merge.sh
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
   cpu:
               interger: number of cpus
   ids:
               txt file containing the ids of the runs (file name before .fastq), in case of paired it's only necessary the file name before _1.fastq or _2.fastq

##create_MANIFEST
