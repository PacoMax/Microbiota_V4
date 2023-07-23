dates=$(date +"%d_%m_%Y")
export LC_ALL=en_US.utf-8 #two lines for ASQII phyton issues
export LANG=en_US.utf-8
#TABLES
#V4
qiime feature-table merge \
--i-tables /home/fgonzale/fgonzale/Salamander_project/EMANUEL/EMANUEL_1/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/EMANUEL/EMANUEL_2/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/ANGEL/demux_angels/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/eLife.53898/Newt_FASTQ/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/ENRIQUE/reads/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/ERP003771/reads/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRE/PRE_LSS/PRE_LSS/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA320969/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA320971/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA368730/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA368738/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA477390/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA549036/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA574188/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA590016/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA659464/reads_v2/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA731185/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA830991/Illumina_V4/table_Illumina_V4_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA843333/Illumina_V4/table_Illumina_V4_23_07_2023.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA854639/Illumina_V4/table_Illumina_V4_23_07_2023.qza \
--o-merged-table insertion-table_V4_${dates}.qza
#V3,V34
qiime feature-table merge \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA505069_PRJNA432888/Illumina_V34/table_Illumina_V34_06_07_2022.qza \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA632638/Illumina_V3/table_Illumina_V3_06_07_2022.qza \
--o-merged-table insertion-table_V34_${dates}.qza
#V2
qiime feature-table merge \
--i-tables /home/fgonzale/fgonzale/Salamander_project/PRJNA382978/Illumina_V2/table_Illumina_V2_06_07_2022.qza \
--o-merged-table insertion-table_V2_${dates}.qza

#REP-SEQS
#V4
qiime feature-table merge-seqs \
--i-data /home/fgonzale/fgonzale/Salamander_project/EMANUEL/EMANUEL_1/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/EMANUEL/EMANUEL_2/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/ANGEL/demux_angels/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/eLife.53898/Newt_FASTQ/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/ENRIQUE/reads/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/ERP003771/reads/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRE/PRE_LSS/PRE_LSS/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA320969/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA320971/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA368730/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA368738/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA477390/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA549036/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA574188/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA590016/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA659464/reads_v2/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA731185/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA830991/Illumina_V4/rep_Illumina_V4_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA843333/Illumina_V4/rep_Illumina_V4_23_07_2023.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA854639/Illumina_V4/rep_Illumina_V4_23_07_2023.qza \
--o-merged-data insertion-rep-seqs_V4_${dates}.qza
#V3,V34
qiime feature-table merge-seqs \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA505069_PRJNA432888/Illumina_V34/rep_Illumina_V34_06_07_2022.qza \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA632638/Illumina_V3/rep_Illumina_V3_06_07_2022.qza \
--o-merged-data insertion-rep-seqs_V34_${dates}.qza
#V2
qiime feature-table merge-seqs \
--i-data /home/fgonzale/fgonzale/Salamander_project/PRJNA382978/Illumina_V2/rep_Illumina_V2_06_07_2022.qza \
--o-merged-data insertion-rep-seqs_V2_${dates}.qza
