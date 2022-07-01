# Microbiota_V4
Scripts for analyzing microbiotas using Illumina paired and single-end reads containing 16S gene V2, V3, V34, V35 and V4 regions, and for obtaining bioclimate and biome data.

   ### download_sra.sh
   
This script downloads a list of Sequence Read Archive (SRA) fastq files, available through NCBI servers.

To run this program it's necesary to install the SRA Toolkit and create a txt file with SRA IDs called SRA.list.

      Usage: download_sra.sh

The sequence files will be download in a directory called reads.
There are two options in case you don't have enough space in your ncbi automatic created directory.

   ### clean_and_merge.sh

This script cleand and prepares squences to be processed by V4 single end, V34 single end, V35 single end and V2 single end dada2 pipeline.
V2 only works with single-end while V3 and V35 only with paired-end. It is necesary previously remove adapters

To run this program it's necesary to install these programs:

trimmomatic

prinseq-lite.pl

pear

      Usage: clean_and_merge.sh [region] [type] [cpu] [ids]
  
  region:
   
    2       : V2
    
    3       : V3

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

This script creates a MANIFEST file with the sequences from the directory Illumina_V4 created by clean_and_merge.sh

      Usage: MANIFEST_creator.sh

   ### import_and_dada2.sh
   
This script imports squences to be processed by dada2 pipeline.

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
   
   rare:
            
               interger: maximum rarefaction size
               
               
   ### merge_V24.sh
   
   This script merges imported data from sequences of different run and 16S regions (V2 and V4). It also can be modify in order to include more 16S regions.
   Before run this,it's necesary to download the updated silva tree version.
   
   ### taxonomy.sh
   ### filter_tax.sh
