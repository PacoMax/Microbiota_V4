for i in $(cat PATHs_Illumina);
do
j=$(echo "$i" | rev | cut -d '_' -f1 | rev | sed 's/V//g');
import_and_dada2.sh MANIFEST* 20 10000 23000 $j
done
