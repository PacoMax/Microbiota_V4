###MDS
library(vegan)
library("ggplot2")
#wu


infossm<-read.csv("Super_table_27_07_22_V2_60.csv")

infossm2<-infossm[-which(infossm$origin=="captive"),]


wu<-read.table("wu_distance-matrix.tsv")
wu<-read.table("u_distance-matrix.tsv")
wu<-read.table("bray_distance-matrix.tsv")

colnames(wu)<-rownames(wu)


wu2<-wu[infossm2$Sample_id,infossm2$Sample_id]

permanova_P <- adonis(wu2 ~ Population_geo, data = infossm2,permutations = 999)

permanova_O <- adonis(wu2 ~ Org_Mor, data = infossm2,permutations = 999)

permanova_S <- adonis(wu2 ~ Organism, data = infossm2,permutations = 999)

permanova_E <- adonis(wu2 ~ ECO_NAME, data = infossm2,permutations = 999)

permanova_T <- adonis(wu2 ~ Study, data = infossm2,permutations = 999)

permanova_F <- adonis(wu2 ~ Family, data = infossm2,permutations = 999)

permanova_R <- adonis(wu2 ~ R.S., data = infossm2,permutations = 999)

permanova_B <- adonis(wu2~ BIOME, data = infossm2,permutations = 999)

permanova_16 <- adonis(wu2 ~ region_16S, data = infossm2,permutations = 999)

permanova_H <- adonis(wu2 ~ morphotype, data = infossm2,permutations = 999)

######

permanova_bio19 <- adonis(wu2 ~ bio19, data = infossm2,permutations = 999)
permanova_bio18 <- adonis(wu2 ~ bio18, data = infossm2,permutations = 999)
permanova_bio17 <- adonis(wu2 ~ bio17, data = infossm2,permutations = 999)
permanova_bio16 <- adonis(wu2 ~ bio16, data = infossm2,permutations = 999)
permanova_bio15 <- adonis(wu2 ~ bio15, data = infossm2,permutations = 999)
permanova_bio14 <- adonis(wu2 ~ bio14, data = infossm2,permutations = 999)
permanova_bio13 <- adonis(wu2 ~ bio13, data = infossm2,permutations = 999)
permanova_bio12 <- adonis(wu2 ~ bio12, data = infossm2,permutations = 999)
permanova_bio11 <- adonis(wu2 ~ bio11, data = infossm2,permutations = 999)
permanova_bio10 <- adonis(wu2 ~ bio10, data = infossm2,permutations = 999)
permanova_bio9 <- adonis(wu2 ~ bio9, data = infossm2,permutations = 999)
permanova_bio8 <- adonis(wu2 ~ bio8, data = infossm2,permutations = 999)
permanova_bio7 <- adonis(wu2 ~ bio7, data = infossm2,permutations = 999)
permanova_bio6 <- adonis(wu2 ~ bio6, data = infossm2,permutations = 999)
permanova_bio5 <- adonis(wu2 ~ bio5, data = infossm2,permutations = 999)
permanova_bio4 <- adonis(wu2 ~ bio4, data = infossm2,permutations = 999)
permanova_bio3 <- adonis(wu2 ~ bio3, data = infossm2,permutations = 999)
permanova_bio2 <- adonis(wu2 ~ bio2, data = infossm2,permutations = 999)
permanova_bio1 <- adonis(wu2 ~ bio1, data = infossm2,permutations = 999)
permanova_tmax <- adonis(wu2 ~ tm_max, data = infossm2,permutations = 999)
permanova_tmin <- adonis(wu2 ~ tm_min, data = infossm2,permutations = 999)
permanova_pre <- adonis(wu2 ~ pre, data = infossm2,permutations = 999)
permanova_elevation <- adonis(wu2 ~ elevation, data = infossm2,permutations = 999)



#####

Permanovas_wu<-data.frame(r2=c(
  permanova_P$aov.tab$R2[1],
  permanova_O$aov.tab$R2[1],
  permanova_S$aov.tab$R2[1],
  permanova_E$aov.tab$R2[1],
  permanova_T$aov.tab$R2[1],
  permanova_F$aov.tab$R2[1],
  permanova_B$aov.tab$R2[1],
  permanova_R$aov.tab$R2[1],
  permanova_H$aov.tab$R2[1],
  permanova_16$aov.tab$R2[1],
  permanova_bio19$aov.tab$R2[1],
  permanova_bio18$aov.tab$R2[1],
  permanova_bio17$aov.tab$R2[1],
  permanova_bio16$aov.tab$R2[1],
  permanova_bio15$aov.tab$R2[1],
  permanova_bio14$aov.tab$R2[1],
  permanova_bio13$aov.tab$R2[1],
  permanova_bio12$aov.tab$R2[1],
  permanova_bio11$aov.tab$R2[1],
  permanova_bio10$aov.tab$R2[1],
  permanova_bio9$aov.tab$R2[1],
  permanova_bio8$aov.tab$R2[1],
  permanova_bio7$aov.tab$R2[1],
  permanova_bio6$aov.tab$R2[1],
  permanova_bio5$aov.tab$R2[1],
  permanova_bio4$aov.tab$R2[1],
  permanova_bio3$aov.tab$R2[1],
  permanova_bio2$aov.tab$R2[1],
  permanova_bio1$aov.tab$R2[1],
  permanova_tmax$aov.tab$R2[1],
  permanova_tmin$aov.tab$R2[1],
  permanova_pre$aov.tab$R2[1],
  permanova_elevation$aov.tab$R2[1]
),
Df=c(
  permanova_P$aov.tab$Df[1],
  permanova_O$aov.tab$Df[1],
  permanova_S$aov.tab$Df[1],
  permanova_E$aov.tab$Df[1],
  permanova_T$aov.tab$Df[1],
  permanova_F$aov.tab$Df[1],
  permanova_B$aov.tab$Df[1],
  permanova_R$aov.tab$Df[1],
  permanova_H$aov.tab$Df[1],
  permanova_16$aov.tab$Df[1],
  permanova_bio19$aov.tab$Df[1],
  permanova_bio18$aov.tab$Df[1],
  permanova_bio17$aov.tab$Df[1],
  permanova_bio16$aov.tab$Df[1],
  permanova_bio15$aov.tab$Df[1],
  permanova_bio14$aov.tab$Df[1],
  permanova_bio13$aov.tab$Df[1],
  permanova_bio12$aov.tab$Df[1],
  permanova_bio11$aov.tab$Df[1],
  permanova_bio10$aov.tab$Df[1],
  permanova_bio9$aov.tab$Df[1],
  permanova_bio8$aov.tab$Df[1],
  permanova_bio7$aov.tab$Df[1],
  permanova_bio6$aov.tab$Df[1],
  permanova_bio5$aov.tab$Df[1],
  permanova_bio4$aov.tab$Df[1],
  permanova_bio3$aov.tab$Df[1],
  permanova_bio2$aov.tab$Df[1],
  permanova_bio1$aov.tab$Df[1],
  permanova_tmax$aov.tab$Df[1],
  permanova_tmin$aov.tab$Df[1],
  permanova_pre$aov.tab$Df[1],
  permanova_elevation$aov.tab$Df[1]
),
F.Model=c(
  permanova_P$aov.tab$F.Model[1],
  permanova_O$aov.tab$F.Model[1],
  permanova_S$aov.tab$F.Model[1],
  permanova_E$aov.tab$F.Model[1],
  permanova_T$aov.tab$F.Model[1],
  permanova_F$aov.tab$F.Model[1],
  permanova_B$aov.tab$F.Model[1],
  permanova_R$aov.tab$F.Model[1],
  permanova_H$aov.tab$F.Model[1],
  permanova_16$aov.tab$F.Model[1],
  permanova_bio19$aov.tab$F.Model[1],
  permanova_bio18$aov.tab$F.Model[1],
  permanova_bio17$aov.tab$F.Model[1],
  permanova_bio16$aov.tab$F.Model[1],
  permanova_bio15$aov.tab$F.Model[1],
  permanova_bio14$aov.tab$F.Model[1],
  permanova_bio13$aov.tab$F.Model[1],
  permanova_bio12$aov.tab$F.Model[1],
  permanova_bio11$aov.tab$F.Model[1],
  permanova_bio10$aov.tab$F.Model[1],
  permanova_bio9$aov.tab$F.Model[1],
  permanova_bio8$aov.tab$F.Model[1],
  permanova_bio7$aov.tab$F.Model[1],
  permanova_bio6$aov.tab$F.Model[1],
  permanova_bio5$aov.tab$F.Model[1],
  permanova_bio4$aov.tab$F.Model[1],
  permanova_bio3$aov.tab$F.Model[1],
  permanova_bio2$aov.tab$F.Model[1],
  permanova_bio1$aov.tab$F.Model[1],
  permanova_tmax$aov.tab$F.Model[1],
  permanova_tmin$aov.tab$F.Model[1],
  permanova_pre$aov.tab$F.Model[1],
  permanova_elevation$aov.tab$F.Model[1]
),
p.value=c(
  permanova_P$aov.tab$`Pr(>F)`[1],
  permanova_O$aov.tab$`Pr(>F)`[1],
  permanova_S$aov.tab$`Pr(>F)`[1],
  permanova_E$aov.tab$`Pr(>F)`[1],
  permanova_T$aov.tab$`Pr(>F)`[1],
  permanova_F$aov.tab$`Pr(>F)`[1],
  permanova_B$aov.tab$`Pr(>F)`[1],
  permanova_R$aov.tab$`Pr(>F)`[1],
  permanova_H$aov.tab$`Pr(>F)`[1],
  permanova_16$aov.tab$`Pr(>F)`[1],
  permanova_bio19$aov.tab$`Pr(>F)`[1],
  permanova_bio18$aov.tab$`Pr(>F)`[1],
  permanova_bio17$aov.tab$`Pr(>F)`[1],
  permanova_bio16$aov.tab$`Pr(>F)`[1],
  permanova_bio15$aov.tab$`Pr(>F)`[1],
  permanova_bio14$aov.tab$`Pr(>F)`[1],
  permanova_bio13$aov.tab$`Pr(>F)`[1],
  permanova_bio12$aov.tab$`Pr(>F)`[1],
  permanova_bio11$aov.tab$`Pr(>F)`[1],
  permanova_bio10$aov.tab$`Pr(>F)`[1],
  permanova_bio9$aov.tab$`Pr(>F)`[1],
  permanova_bio8$aov.tab$`Pr(>F)`[1],
  permanova_bio7$aov.tab$`Pr(>F)`[1],
  permanova_bio6$aov.tab$`Pr(>F)`[1],
  permanova_bio5$aov.tab$`Pr(>F)`[1],
  permanova_bio4$aov.tab$`Pr(>F)`[1],
  permanova_bio3$aov.tab$`Pr(>F)`[1],
  permanova_bio2$aov.tab$`Pr(>F)`[1],
  permanova_bio1$aov.tab$`Pr(>F)`[1],
  permanova_tmax$aov.tab$`Pr(>F)`[1],
  permanova_tmin$aov.tab$`Pr(>F)`[1],
  permanova_pre$aov.tab$`Pr(>F)`[1],
  permanova_elevation$aov.tab$`Pr(>F)`[1]
))


rownames(Permanovas_wu)<-c(
  "P",
  "O",
  "S",
  "E",
  "T",
  "F",
  "B",
  "R",
  "H",
  "16S",
  "bio19",
  "bio18",
  "bio17",
  "bio16",
  "bio15",
  "bio14",
  "bio13",
  "bio12",
  "bio11",
  "bio10",
  "bio9",
  "bio8",
  "bio7",
  "bio6",
  "bio5",
  "bio4",
  "bio3",
  "bio2",
  "bio1",
  "tmax",
  "tmin",
  "pre",
  "elevation"
)


#write.csv(file="Permanovas_wu_12_09_22.csv", Permanovas_wu)
#write.csv(file="Permanovas_u_12_09_22.csv", Permanovas_wu)
write.csv(file="Permanovas_b_12_09_22.csv", Permanovas_wu)

