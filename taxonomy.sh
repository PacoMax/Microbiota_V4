#!/usr/bin/env bash
if [ "$1" == "-h" ]; then
echo ""
echo "  To run this program it's necesary to install and activate qiime2 version 2021 2"
echo ""
echo "  Usage: `basename $0` [region] [cpus]"
echo ""
        echo "  region:"
                echo  "         2       : V2 only single-end"
                echo  "         3       : V3 ony paired-end"
                echo  "         34      : V3-V4"
                echo  "         4       : V4"
                echo  "         35      : V3-V5 only paired-end"
        echo "  cpu:"
                echo  "         interger: number of cpus"
echo ""
exit 0
fi
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8

region=${1?Error: No region specified. Please, ask for help (clean_merge.sh -h)}
cpu=${2?Error: No number of cpus specified. Please, ask for help (clean_merge.sh -h)}
dates=$(date +"%d_%m_%Y")

qiime feature-classifier classify-sklearn --i-classifier  ref-seqs-tain-v${region}.qza --i-reads insertion-rep-seqs_V${region}_* --o-classification tax-v${region}_${dates}.qza --p-read-orientation 'same' --p-n-jobs $cpu
