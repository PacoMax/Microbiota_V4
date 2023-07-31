# Microbiota_V4
Scripts for analyzing microbiotas using Illumina paired and single-end reads containing 16S gene V2, V3, V34, V35 and V4 regions, and for obtaining bioclimate and biome data.

   ### download_sra.sh
   
This script downloads a list of Sequence Read Archive (SRA) fastq files, available through NCBI servers.

To run this program it's necessary to install the SRA Toolkit and create a txt file with SRA IDs called SRA.list.

      Usage: download_sra.sh

The sequence files will be downloaded in a directory called reads.
There are two options in case you don't have enough space in your ncbi automatically created directory.

   ### clean_and_merge.sh

This script cleans and prepares sequences to be processed by V4 single end, V34 single end, V35 single end, and V2 single end dada2 pipeline.
V2 only works with single-end while V3 and V35 only with paired-end. It is necessary previously remove adapters

To run this program it's necessary to install these programs:

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
   
This script imports sequences to be processed by dada2 pipeline.

To run this program it's necessary to activate qiime2 environment.

This pipeline cut all the reads to 100 bp length.

To change that, you can edit this script with a text editor in the option --p-trunc-len (default 100bp).

      Usage: import_and_dada2.sh [MANIFEST] [cpus] [learn]

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
               
   ### run_merge_Vs.sh
   
   This script merges all the data by 16S region. 
   It would be best if you modified it to work with your files' correct locations.
   
   ### Preparing_RDP_class.sh
   
   This script prepares RDP database for annotation using taxonomy.sh script for different 16S regions.
   
   ### taxonomy.sh
   
   This script is for the annotation of different 16S regions using the RDP trained database from Preparing_RDP_class.sh
   
        Usage: import_and_dada2.sh [region] [cpus] 

   ### taxfilt.sh
   
   This script merges imported data from sequences of different run and 16S regions (V2 and V4) and their taxonomy annotation.
   It also filter the data from mitochondrial and chloroplast sequences and rarefied the data at 2300.
   Before running this, it's necessary to download the updated silva tree version.
   
           Usage: taxfilt.sh [cpus] 

           cpus: interger: number of cpus

   ### beta_alpha.sh

   This script calculates the beta and alpha diversity metrics. 
   To run this program it's necessary to activate qiime2 environment.
   The output is a directory named core_diversity_date. It contains the diversity metrics

         Usage: beta_alpha.sh [metadata] [table] [tree] [cpus]

         metadata: txt file which should look like:
         Sample.ID  Data1  Data2  Data3
                  
         table:   ASV file (output of DADA2)
      
         tree:   qza containing the tree
      
         cpus: interger: number of cpus

   ## collapse_level.sh

   This script uses the insertion-V234-table-filt.qza file and the insertion-tax.qza
   and creates a directory collapse where create a list of otus files per taxonomical level.
   You should run it in the directory where the required files are located.
   
      Usage: collapse_level.sh
