if [ "$1" == "-h" ]; then
echo ""
echo "  Welcome to tree.sh"
echo "  This script makes an aligment and a tree of representative otus"
echo "  To run this program it's necesary to activate qiime2 enviroment"
echo ""
echo ""
echo "  Usage: `basename $0` [dir] [cpus]"
echo ""
echo "  dir:"
               echo "          Name of the directory where the files are:"
echo ""
echo "  cpus:"
               echo  "         interger: number of cpus"
echo ""
echo ""

exit 0
fi
dir=${1?Error: No directory specified. Please, ask for help (./tree.sh -h)}
cpus=${2?Error: No number of cpus specified. Please, ask for help (./tree.sh -h)}

export LC_ALL=en_US.utf-8 #two lines for ASQII phyton issues
export LANG=en_US.utf-8

qiime alignment mafft --i-sequences ${dir}/rep_* --p-n-threads 12 --o-alignment ${dir}/aligned-rep_${dir}.qza
qiime alignment mask --i-alignment ${dir}/aligned-rep_${dir}.qza --o-masked-alignment ${dir}/masked-aligned-rep_${dir}.qza
qiime phylogeny fasttree --i-alignment ${dir}/masked-aligned-rep_${dir}.qza --p-n-threads 12 --o-tree ${dir}/unrooted-tree-${dir}.qza
qiime phylogeny midpoint-root --i-tree ${dir}/unrooted-tree-${dir}.qza --o-rooted-tree ${dir}/rooted-tree-${dir}.qza
