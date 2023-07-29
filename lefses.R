library(microbiomeMarker)
library(qiime2R)
library(phyloseq)
library(survminer)
library(ggsci)
# LefSe at Order level 

phy_bac <- qza_to_phyloseq("New_data_meta_25072023/insertion-V234-table-filt_2300_25_07_2023.qza", 
                          "New_data_meta_25072023/insertion-tree_23_07_2023.qza", 
                           "New_data_meta_25072023/insertion-tax_23_07_2023.qza",
                           "New_data_meta_25072023/Metadata_25_07_2023.tsv")

#Deleting extra samples
to_remove<-c("G1_11",
             "G1_12",
             "LS023_ER8125-1_S23",
             "LS078_ER8125-1_S76",
             "LS224_ER8125-1_S208",
             "O035_ER8125-1_S35",
             "O040_ER8125-1_S40",
             "O050_ER8125-1_S50",
             "O052_ER8125-1_S51",
             "O103_ER8125-1_S100",
             "O110_ER8125-1_S107",
             "O112_ER8125-1_S109",
             "O118_ER8125-1_S115",
             "O146_ER8125-1_S138",
             "O160_ER8125-1_S150",
             "S008_ER8125-1_S8",
             "S093_ER8125-1_S90",
             "T001_ER8125-1_S1",
             "O051_ER8125-2_S1",
             "O161_ER8125-2_S5",
             "O246_ER8125-2_S15",
             "O253_ER8125-2_S22",
             "O259_ER8125-2_S28",
             "O261_ER8125-2_S30",
             "O262_ER8125-2_S31",
             "O264_ER8125-2_S33",
             "SRR7614804",
             "SRR7614881",
             "SRR7614885",
             "SRR7614908",
             "SRR7614909",
             "SRR7614912",
             "SRR7614913",
             "SRR7614922",
             "SRR7614925",
             "SRR7614936",
             "SRR7614939",
             "SRR7614957",
             "SRR10190507",
             "SRR10190508",
             "SRR10190510",
             "SRR10190524",
             "SRR10190525",
             "SRR10190526",
             "SRR10190528",
             "SRR10190530",
             "SRR10190532",
             "SRR10190533",
             "SRR14601279",
             "SRR14601282",
             "SRR14601284",
             "SRR14601285",
             "SRR14601287",
             "SRR14601299",
             "SRR14601338",
             "SRR14601341",
             "SRR14601343",
             "SRR14601345",
             "SRR14601347",
             "SRR14601355",
             "SRR14601361",
             "SRR14601363",
             "SRR14601368",
             "SRR14601371",
             "SRR14601380",
             "SRR14601385",
             "SRR14601387",
             "SRR14601392",
             "SRR14601395",
             "SRR14601398",
             "SRR14601405",
             "SRR14601407",
             "SRR14601408",
             "SRR14601418",
             "SRR14601449",
             "SRR14601453",
             "SRR14601456",
             "SRR14601462",
             "SRR14601472",
             "SRR14601491",
             "SRR14601493",
             "SRR14601497",
             "SRR14601499",
             "SRR14601511",
             "SRR14601512",
             "SRR14601516",
             "SRR14601517",
             "SRR14601518",
             "SRR14601536",
             "SRR7169522",
             "SRR7169533",
             "SRR7169534")


phy_bac_f <- prune_samples(!(sample_names(phy_bac) %in% to_remove), phy_bac)


length(sample_names(phy_bac_f))

lefse_bac_family_order <- run_lefse(
  phy_bac_f,      #archivo phyloseq que contiene tabla de otus, taxonónimca, de la metadada y el arbol
  wilcoxon_cutoff = 0.05,
  group = "Family",
  taxa_rank = "Order",
  kw_cutoff = 0.05,
  multigrp_strat = T,
  lda_cutoff = 2
)

lefse_df_bac_family_order <- as.data.frame(lefse_bac_family_order@marker_table)


write.csv(file="lbfo.csv", as.matrix(lefse_df_bac_family_order), row.names = F)




lefse_bac_family_order <-plot_ef_bar(lefse_df_bac_family_order) + theme_classic2() + scale_fill_locuszoom()+
  theme(legend.text=element_text(size=15, face = "bold.italic"),
        legend.title = element_text(size = 15, face="bold"),
        axis.text.x=element_text(size = 14, color = "black", face = "bold"),
        axis.title.x =element_text(size = 14, color = "black", face = "bold"),
        axis.text.y =element_text(size = 8, color = "black", face = "bold")) +
  guides(fill=guide_legend(title="Family"))+
  geom_bar(color = "black",size=0.7,stat="identity")
lefse_bac_family_order




lefse_bac_morphotype_order <- run_lefse(
  phy_bac_f,      #archivo phyloseq que contiene tabla de otus, taxonónimca, de la metadada y el arbol
  wilcoxon_cutoff = 0.05,
  group = "morphotype",
  taxa_rank = "Order",
  kw_cutoff = 0.05,
  multigrp_strat = T,
  lda_cutoff = 2
)

lefse_df_bac_morphotype_order <- as.data.frame(lefse_bac_morphotype_order@marker_table)


write.csv(file="lbho.csv", as.matrix(lefse_df_bac_morphotype_order), row.names = F)




lefse_bac_morphotype_order <-plot_ef_bar(lefse_df_bac_morphotype_order) + theme_classic2() + scale_fill_locuszoom()+
  theme(legend.text=element_text(size=15, face = "bold.italic"),
        legend.title = element_text(size = 15, face="bold"),
        axis.text.x=element_text(size = 14, color = "black", face = "bold"),
        axis.title.x =element_text(size = 14, color = "black", face = "bold"),
        axis.text.y =element_text(size = 8, color = "black", face = "bold")) +
  guides(fill=guide_legend(title="Habitat"))+
  geom_bar(color = "black",size=0.7,stat="identity")
lefse_bac_morphotype_order






