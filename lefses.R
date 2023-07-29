library(microbiomeMarker)
library(qiime2R)
library(phyloseq)
library(survminer)
library(ggsci)
# LefSe at Order level 

phy_bac_f <- qza_to_phyloseq("New_data_meta_25072023/insertion-V234-table-filt_2300_25_07_2023.qza", 
                          "New_data_meta_25072023/insertion-tree_23_07_2023.qza", 
                           "New_data_meta_25072023/insertion-tax_23_07_2023.qza",
                           "New_data_meta_25072023/Metadata_25_07_2023.tsv")



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






