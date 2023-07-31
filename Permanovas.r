
library(vegan)
library("ggplot2")


infossm<-read.csv("Data_supertable.csv")

infossm2<-infossm[-which(infossm$origin=="captive"),]


w<-read.table("weighted.tsv")
uw<-read.table("unweighted.tsv")
b<-read.table("braycurtis.tsv")

matr<-list(w,uw,b)
names<-c("weighted", "unweighted", "braycurtis")

k=0
for(i in matr){

  beta<-i
  colnames(beta)<-rownames(beta)
  beta2<-beta[infossm2$Sample.ID,infossm2$Sample.ID]
  
  permanova_P <- adonis2(beta2 ~ Population_geo, data = infossm2,permutations = 999)
  
  permanova_O <- adonis2(beta2 ~ Org_Mor, data = infossm2,permutations = 999)
  
  permanova_S <- adonis2(beta2 ~ Organism, data = infossm2,permutations = 999)
  
  permanova_E <- adonis2(beta2 ~ ECO_NAME, data = infossm2,permutations = 999)
  
  permanova_T <- adonis2(beta2 ~ Study, data = infossm2,permutations = 999)
  
  permanova_F <- adonis2(beta2 ~ Family, data = infossm2,permutations = 999)
  
  permanova_R <- adonis2(beta2 ~ R.S., data = infossm2,permutations = 999)
  
  permanova_B <- adonis2(beta2~ BIOME, data = infossm2,permutations = 999)
  
  permanova_16 <- adonis2(beta2 ~ region_16S, data = infossm2,permutations = 999)
  
  permanova_H <- adonis2(beta2 ~ habitat, data = infossm2,permutations = 999)
  
  ######
  
  permanova_bio19 <- adonis2(beta2 ~ bio19, data = infossm2,permutations = 999)
  permanova_bio18 <- adonis2(beta2 ~ bio18, data = infossm2,permutations = 999)
  permanova_bio17 <- adonis2(beta2 ~ bio17, data = infossm2,permutations = 999)
  permanova_bio16 <- adonis2(beta2 ~ bio16, data = infossm2,permutations = 999)
  permanova_bio15 <- adonis2(beta2 ~ bio15, data = infossm2,permutations = 999)
  permanova_bio14 <- adonis2(beta2 ~ bio14, data = infossm2,permutations = 999)
  permanova_bio13 <- adonis2(beta2 ~ bio13, data = infossm2,permutations = 999)
  permanova_bio12 <- adonis2(beta2 ~ bio12, data = infossm2,permutations = 999)
  permanova_bio11 <- adonis2(beta2 ~ bio11, data = infossm2,permutations = 999)
  permanova_bio10 <- adonis2(beta2 ~ bio10, data = infossm2,permutations = 999)
  permanova_bio9 <- adonis2(beta2 ~ bio9, data = infossm2,permutations = 999)
  permanova_bio8 <- adonis2(beta2 ~ bio8, data = infossm2,permutations = 999)
  permanova_bio7 <- adonis2(beta2 ~ bio7, data = infossm2,permutations = 999)
  permanova_bio6 <- adonis2(beta2 ~ bio6, data = infossm2,permutations = 999)
  permanova_bio5 <- adonis2(beta2 ~ bio5, data = infossm2,permutations = 999)
  permanova_bio4 <- adonis2(beta2 ~ bio4, data = infossm2,permutations = 999)
  permanova_bio3 <- adonis2(beta2 ~ bio3, data = infossm2,permutations = 999)
  permanova_bio2 <- adonis2(beta2 ~ bio2, data = infossm2,permutations = 999)
  permanova_bio1 <- adonis2(beta2 ~ bio1, data = infossm2,permutations = 999)
  permanova_tmax <- adonis2(beta2 ~ tm_max, data = infossm2,permutations = 999)
  permanova_tmin <- adonis2(beta2 ~ tm_min, data = infossm2,permutations = 999)
  permanova_pre <- adonis2(beta2 ~ pre, data = infossm2,permutations = 999)
  permanova_elevation <- adonis2(beta2 ~ elevation, data = infossm2,permutations = 999)
  
  
  
  #####
  
  Permanovas<-data.frame(r2=c(
    permanova_P$R2[1],
    permanova_O$R2[1],
    permanova_S$R2[1],
    permanova_E$R2[1],
    permanova_T$R2[1],
    permanova_F$R2[1],
    permanova_B$R2[1],
    permanova_R$R2[1],
    permanova_H$R2[1],
    permanova_16$R2[1],
    permanova_bio19$R2[1],
    permanova_bio18$R2[1],
    permanova_bio17$R2[1],
    permanova_bio16$R2[1],
    permanova_bio15$R2[1],
    permanova_bio14$R2[1],
    permanova_bio13$R2[1],
    permanova_bio12$R2[1],
    permanova_bio11$R2[1],
    permanova_bio10$R2[1],
    permanova_bio9$R2[1],
    permanova_bio8$R2[1],
    permanova_bio7$R2[1],
    permanova_bio6$R2[1],
    permanova_bio5$R2[1],
    permanova_bio4$R2[1],
    permanova_bio3$R2[1],
    permanova_bio2$R2[1],
    permanova_bio1$R2[1],
    permanova_tmax$R2[1],
    permanova_tmin$R2[1],
    permanova_pre$R2[1],
    permanova_elevation$R2[1]
  ),
  Df=c(
    permanova_P$Df[1],
    permanova_O$Df[1],
    permanova_S$Df[1],
    permanova_E$Df[1],
    permanova_T$Df[1],
    permanova_F$Df[1],
    permanova_B$Df[1],
    permanova_R$Df[1],
    permanova_H$Df[1],
    permanova_16$Df[1],
    permanova_bio19$Df[1],
    permanova_bio18$Df[1],
    permanova_bio17$Df[1],
    permanova_bio16$Df[1],
    permanova_bio15$Df[1],
    permanova_bio14$Df[1],
    permanova_bio13$Df[1],
    permanova_bio12$Df[1],
    permanova_bio11$Df[1],
    permanova_bio10$Df[1],
    permanova_bio9$Df[1],
    permanova_bio8$Df[1],
    permanova_bio7$Df[1],
    permanova_bio6$Df[1],
    permanova_bio5$Df[1],
    permanova_bio4$Df[1],
    permanova_bio3$Df[1],
    permanova_bio2$Df[1],
    permanova_bio1$Df[1],
    permanova_tmax$Df[1],
    permanova_tmin$Df[1],
    permanova_pre$Df[1],
    permanova_elevation$Df[1]
  ),
  F.Model=c(
    permanova_P$F[1],
    permanova_O$F[1],
    permanova_S$F[1],
    permanova_E$F[1],
    permanova_T$F[1],
    permanova_F$F[1],
    permanova_B$F[1],
    permanova_R$F[1],
    permanova_H$F[1],
    permanova_16$F[1],
    permanova_bio19$F[1],
    permanova_bio18$F[1],
    permanova_bio17$F[1],
    permanova_bio16$F[1],
    permanova_bio15$F[1],
    permanova_bio14$F[1],
    permanova_bio13$F[1],
    permanova_bio12$F[1],
    permanova_bio11$F[1],
    permanova_bio10$F[1],
    permanova_bio9$F[1],
    permanova_bio8$F[1],
    permanova_bio7$F[1],
    permanova_bio6$F[1],
    permanova_bio5$F[1],
    permanova_bio4$F[1],
    permanova_bio3$F[1],
    permanova_bio2$F[1],
    permanova_bio1$F[1],
    permanova_tmax$F[1],
    permanova_tmin$F[1],
    permanova_pre$F[1],
    permanova_elevation$F[1]
  ),
  p.value=c(
    permanova_P$`Pr(>F)`[1],
    permanova_O$`Pr(>F)`[1],
    permanova_S$`Pr(>F)`[1],
    permanova_E$`Pr(>F)`[1],
    permanova_T$`Pr(>F)`[1],
    permanova_F$`Pr(>F)`[1],
    permanova_B$`Pr(>F)`[1],
    permanova_R$`Pr(>F)`[1],
    permanova_H$`Pr(>F)`[1],
    permanova_16$`Pr(>F)`[1],
    permanova_bio19$`Pr(>F)`[1],
    permanova_bio18$`Pr(>F)`[1],
    permanova_bio17$`Pr(>F)`[1],
    permanova_bio16$`Pr(>F)`[1],
    permanova_bio15$`Pr(>F)`[1],
    permanova_bio14$`Pr(>F)`[1],
    permanova_bio13$`Pr(>F)`[1],
    permanova_bio12$`Pr(>F)`[1],
    permanova_bio11$`Pr(>F)`[1],
    permanova_bio10$`Pr(>F)`[1],
    permanova_bio9$`Pr(>F)`[1],
    permanova_bio8$`Pr(>F)`[1],
    permanova_bio7$`Pr(>F)`[1],
    permanova_bio6$`Pr(>F)`[1],
    permanova_bio5$`Pr(>F)`[1],
    permanova_bio4$`Pr(>F)`[1],
    permanova_bio3$`Pr(>F)`[1],
    permanova_bio2$`Pr(>F)`[1],
    permanova_bio1$`Pr(>F)`[1],
    permanova_tmax$`Pr(>F)`[1],
    permanova_tmin$`Pr(>F)`[1],
    permanova_pre$`Pr(>F)`[1],
    permanova_elevation$`Pr(>F)`[1]
  ))
  
  
  rownames(Permanovas)<-c(
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
  
  
  write.csv(file=paste("Permanovas_",names[1+k],"_28_07_2023.csv"), Permanovas)
  k=k+1
}




