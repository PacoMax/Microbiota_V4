#!/usr/bin/env bash
if [ "$1" == "-h" ]; then
echo ""
echo "  Welcome to beta_alpha.sh"
echo "  This script calculates the beta and alpha diversity metrics"
echo "  To run this program it's necessary to activate qiime2 environment"
echo ""
echo " The output is a directory named core_diversity_date"
echo " It contains the diversity metrics"
echo ""
echo "  Usage: `basename $0` [metadata] [table] [tree] [cpus]"
echo ""
echo "  metadata:"
               echo "         txt file which should look like:"
               echo "         Sample.ID  Data1  Data2  Data3"
echo ""
echo "  table:"
               echo  "         ASV file (output of DADA2)"
echo ""
echo "  tree:"
               echo  "         qza containing the tree"
echo ""
echo "  cpus:"
               echo  "         interger: number of cpus"
echo ""
exit 0
fi
metadata=${1?Error: No metadata specified. Please, ask for help (./beta_alpha.sh -h)}
table=${2?Error: No ASV table specified. Please, ask for help (./beta_alpha.sh -h)}
tree=${3?Error: No tree specified. Please, ask for help (./beta_alpha.sh -h)}
cpus=${2?Error: No number of cpus specified. Please, ask for help (./beta_alpha.sh -h)}

export LC_ALL=en_US.utf-8 #two lines for ASQII phyton issues
export LANG=en_US.utf-8
dates=$(date +"%d_%m_%Y")
mkdir core_diversity_${dates}
nohup qiime diversity core-metrics-phylogenetic --i-table $table --m-metadata-file $metadata --i-phylogeny $tree --p-n-jobs-or-threads $cpus \
--p-sampling-depth 2300 --o-rarefied-table core_diversity_${dates}/insertion-V234-table-filt_2300_${dates}.qza \
--o-faith-pd-vector core_diversity_${dates}/faith_V234-table-filt_rare2300 \
--o-observed-features-vector core_diversity_${dates}/observed_V234-table-filt_rare2300 \
--o-shannon-vector core_diversity_${dates}/shannon_V234-table-filt_rare2300 \
--o-evenness-vector core_diversity_25_07_23/evenness_V234-table-filt_rare2300 \
--o-unweighted-unifrac-distance-matrix core_diversity_25_07_23/unweighted_V234-table-filt_rare2300 \
--o-weighted-unifrac-distance-matrix core_diversity_25_07_23/weighted_V234-table-filt_rare2300 \
--o-jaccard-distance-matrix core_diversity_25_07_23/jaccard_V234-table-filt_rare2300 \
--o-bray-curtis-distance-matrix core_diversity_25_07_23/bray_V234-table-filt_rare2300 \
--o-unweighted-unifrac-pcoa-results core_diversity_25_07_23/unweighted_pcoa_V234-table-filt_rare2300 \
--o-weighted-unifrac-pcoa-results core_diversity_25_07_23/weighted_pcoa_V234-table-filt_rare2300 \
--o-jaccard-pcoa-results core_diversity_25_07_23/jaccard_pcoa_V234-table-filt_rare2300 \
--o-bray-curtis-pcoa-results core_diversity_25_07_23/bray_pcoa_V234-table-filt_rare2300 \
--o-unweighted-unifrac-emperor core_diversity_25_07_23/unweighted_emperor_V234-table-filt_rare2300 \
--o-weighted-unifrac-emperor core_diversity_25_07_23/weighted_emperor_V234-table-filt_rare2300 
--o-jaccard-emperor core_diversity_25_07_23/jaccard_emperor_V234-table-filt_rare2300 \
--o-bray-curtis-emperor core_diversity_25_07_23/bray_emperor_V234-table-filt_rare2300
