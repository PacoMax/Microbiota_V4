library(randomForest)
library(purrr)
library(tibble)
library(ggthemes)
library(scales)
library("grid")
library("plyr")
library("ggplot2")
library(reshape)
library(ggpubr)
library(dplyr)
library(tidyr)
library(lme4)
library(EnvStats)
library("Hmisc")

infossm<-read.csv("Super_table_27_07_22_V2_60.csv")

x<-as.data.frame(table(infossm$Org_Mor))


barplot(table(infossm$Population_geo), ylab = "Frequency", main="Population_geo")
barplot(table(infossm$region_16S), ylab = "Frequency", main="Region")
barplot(table(infossm$R.S.), ylab = "Frequency", main="R.S.") #normal
barplot(table(infossm$morphotype), ylab = "Frequency", main="morphotype")#binario
barplot(table(infossm$Org_Mor), ylab = "Frequency", main="Org_Mor")#normal
barplot(table(infossm$BIOME), ylab = "Frequency", main="BIOME")#normal
barplot(table(infossm$ECO_NAME), ylab = "Frequency", main="ECO_NAME")#normal
barplot(table(infossm$Family), ylab = "Frequency", main="Family")
barplot(table(infossm$Study), ylab = "Frequency", main="Study")
barplot(table(infossm$Organism), ylab = "Frequency", main="Specie")#normal


#Bioclim variables
hist(infossm$bio1)
hist(infossm$bio2)
hist(infossm$bio3)
hist(infossm$bio4)
hist(infossm$bio5)
hist(infossm$bio6)
hist(infossm$bio7)
hist(infossm$bio8)
hist(infossm$bio9)
hist(infossm$bio10)
hist(infossm$bio11)
hist(infossm$bio12)
hist(infossm$bio13)
hist(infossm$bio14)
hist(infossm$bio15)
hist(infossm$bio16)
hist(infossm$bio17)
hist(infossm$bio18)
hist(infossm$bio19)



#Variables alpha
hist(infossm$faith_pd)
hist(infossm$shannon_entropy)
hist(infossm$observed_features)



#infossm[,c(15:37,42:45)]<-apply(infossm[,c(15:37,42:45)],2,function(x){scale(x, center = TRUE, scale = TRUE)})



#infossm[,c(15:37,42:45)]<-apply(infossm[,c(15:37,42:45)],2,function(x){log10(x)})
infossm[,c(15:37)]<-apply(infossm[,c(15:37)],2,function(x){scale(x, center = TRUE, scale = TRUE)})


#Log transfromations for evading right skew
infossm$shannon_entropy<-log(infossm$shannon_entropy)
infossm$observed_features<-log(infossm$observed_features)
infossm$faith_pd<-log(infossm$faith_pd)


infossm_c<-infossm[infossm$origin!="captive",]

#Correlation between enviromental and alpha diversity metrics

correla<-rcorr(as.matrix(infossm_c[,c(15:37,42:45)]),type = "pearson")
x<-correla[["r"]]
write.csv(file="Stats_r_v2.csv", x)
x<-correla[["P"]]
write.csv(file="Stats_p_v2.csv", x)
correlas<-rcorr(as.matrix(infossm_c[,c(15:37,42:45)]),type = "spearman")
x<-correlas[["r"]]
write.csv(file="Stats_s_v2.csv", x)
x<-correlas[["P"]]
write.csv(file="Stats_sp_v2.csv", x)

#Step forward reverse

#variables selected 

library("sjstats")
library("MuMIn")
library(performance)
library("see")
library("sjPlot")
library(effects)







infossmw<-infossm_c[,c(15,17:20,25:30,34:37,44)]

colnames(infossmw)





FitStart<-lm(faith_pd ~ 1, data=na.omit(infossmw))

FitAll<-lm(faith_pd ~ ., data=na.omit(infossmw))


step(FitStart,direction = "both",scope = formula(FitAll))



lm1<-lm(formula = faith_pd ~ pre + bio17 + bio11 + elevation + bio12 +
     bio16 + bio19 + bio8 + bio18 + bio2 + bio7 + bio10 + bio9 + 
     bio1, data = na.omit(infossmw))


infossm_c$habitat<-as.numeric(as.factor(infossm_c$morphotype))-1



lmm2.1_c<-lmer(formula = faith_pd ~ pre + bio17 + bio11 + bio12 + bio2 +
                 bio16 + bio8 + bio19 + bio18 + elevation + bio7 + bio10 + bio9 + 
                 bio1 +
                 habitat + (1|Study) + Family, REML=F, data = na.omit(infossm_c))



library("performance")


tabla_VIF<-check_collinearity(lmm2.1_c)



write.csv(tabla_VIF, "table_VIF_lmm.csv")


lmm2.1_s<-lmer(formula = faith_pd ~ pre + bio17   + bio2 +
                 bio16 + bio8 + bio19 + bio18 + elevation + bio7 + bio9 + 
                 
                 habitat + (1|Study) + Family, REML=F, data = na.omit(infossm_c))



tabla_VIF2<-check_collinearity(lmm2.1_s)


write.csv(tabla_VIF2, "table_VIF_lmm2.csv")


anova(lmm2.1_s, lmm2.1_c)


library("MuMIn")

r.squaredGLMM(lmm2.1_c)
r.squaredGLMM(lmm2.1_s)

save(infossm,lmm2.1_s, file = "model_data_31_08_22.RData")


infossm<-read.csv("Super_table_27_07_22_V2_60.csv")

infossm[,c(15:37)]<-apply(infossm[,c(15:37)],2,function(x){scale(x, center = TRUE, scale = TRUE)})

infossm_c<-infossm[infossm$origin!="captive",]

infossm_c$habitat<-as.numeric(as.factor(infossm_c$morphotype))-1




lmm2.1_s_n<-lmer(formula = faith_pd ~ pre + bio17   + bio2 +
                 bio16 + bio8 + bio19 + bio18 + elevation + bio7 + bio9 + 
                 
                 habitat + (1|Study) + Family, REML=F, data = na.omit(infossm_c))


save(infossm,lmm2.1_s_n, file = "model_data_31_08_22_n.RData")











