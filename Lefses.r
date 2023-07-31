library(microbiomeMarker)
library(qiime2R)
library(phyloseq)
library(survminer)
library(ggsci)
# LefSe at Order level 

phy_bac_f <- qza_to_phyloseq("insertion-V234-table-filt_2300.qza", 
                          "insertion-tree.qza", 
                           "insertion-tax.qza",
                           "Metadata.tsv")



length(sample_names(phy_bac_f))


#lvl 4 order

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




lefse_bac_habitat_order <- run_lefse(
  phy_bac_f,      #archivo phyloseq que contiene tabla de otus, taxonónimca, de la metadada y el arbol
  wilcoxon_cutoff = 0.05,
  group = "habitat",
  taxa_rank = "Order",
  kw_cutoff = 0.05,
  multigrp_strat = T,
  lda_cutoff = 2
)

lefse_df_bac_habitat_order <- as.data.frame(lefse_bac_habitat_order@marker_table)


write.csv(file="lbho.csv", as.matrix(lefse_df_bac_habitat_order), row.names = F)




lefse_bac_habitat_order <-plot_ef_bar(lefse_df_bac_habitat_order) + theme_classic2() + scale_fill_locuszoom()+
  theme(legend.text=element_text(size=15, face = "bold.italic"),
        legend.title = element_text(size = 15, face="bold"),
        axis.text.x=element_text(size = 14, color = "black", face = "bold"),
        axis.title.x =element_text(size = 14, color = "black", face = "bold"),
        axis.text.y =element_text(size = 8, color = "black", face = "bold")) +
  guides(fill=guide_legend(title="Habitat"))+
  geom_bar(color = "black",size=0.7,stat="identity")
lefse_bac_habitat_order

#lvl 5 family

lefse_bac_family_family <- run_lefse(
  phy_bac_f,      #archivo phyloseq que contiene tabla de otus, taxonónimca, de la metadada y el arbol
  wilcoxon_cutoff = 0.05,
  group = "Family",
  taxa_rank = "Family",
  kw_cutoff = 0.05,
  multigrp_strat = T,
  lda_cutoff = 2
)

lefse_df_bac_family_family <- as.data.frame(lefse_bac_family_family@marker_table)


write.csv(file="lbff.csv", as.matrix(lefse_df_bac_family_family), row.names = F)




lefse_bac_family_family <-plot_ef_bar(lefse_df_bac_family_family) + theme_classic2() + scale_fill_locuszoom()+
  theme(legend.text=element_text(size=15, face = "bold.italic"),
        legend.title = element_text(size = 15, face="bold"),
        axis.text.x=element_text(size = 14, color = "black", face = "bold"),
        axis.title.x =element_text(size = 14, color = "black", face = "bold"),
        axis.text.y =element_text(size = 8, color = "black", face = "bold")) +
  guides(fill=guide_legend(title="Family"))+
  geom_bar(color = "black",size=0.7,stat="identity")
lefse_bac_family_family




lefse_bac_habitat_family <- run_lefse(
  phy_bac_f,      #archivo phyloseq que contiene tabla de otus, taxonónimca, de la metadada y el arbol
  wilcoxon_cutoff = 0.05,
  group = "habitat",
  taxa_rank = "Family",
  kw_cutoff = 0.05,
  multigrp_strat = T,
  lda_cutoff = 2
)

lefse_df_bac_habitat_family <- as.data.frame(lefse_bac_habitat_family@marker_table)


write.csv(file="lbhf.csv", as.matrix(lefse_df_bac_habitat_family), row.names = F)




lefse_bac_habitat_family <-plot_ef_bar(lefse_df_bac_habitat_family) + theme_classic2() + scale_fill_locuszoom()+
  theme(legend.text=element_text(size=15, face = "bold.italic"),
        legend.title = element_text(size = 15, face="bold"),
        axis.text.x=element_text(size = 14, color = "black", face = "bold"),
        axis.title.x =element_text(size = 14, color = "black", face = "bold"),
        axis.text.y =element_text(size = 8, color = "black", face = "bold")) +
  guides(fill=guide_legend(title="Habitat"))+
  geom_bar(color = "black",size=0.7,stat="identity")
lefse_bac_habitat_family








