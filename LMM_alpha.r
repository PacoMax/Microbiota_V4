#Model
library("sjstats")
library("MuMIn")
library(effects)
library("performance")
library("Hmisc")
library(lme4)
library("sjPlot")
library("MuMIn")

#Reading data

infossm<-read.csv("Data_supertable.csv")
#centralizing the data
infossm[,c(15:37)]<-apply(infossm[,c(15:37)],2,function(x){scale(x, center = TRUE, scale = TRUE)})

infossm_c<-infossm[infossm$origin!="captive",]

##Step one
#Correlation between environmental and alpha diversity metrics


correlas<-rcorr(as.matrix(infossm_c[,c(15:37,42:45)]),type = "spearman")
x<-correlas[["r"]]
write.csv(file="Stats_s_29_07_2023.csv", x)
x<-correlas[["P"]]
write.csv(file="Stats_sp_29_07_2023.csv", x)

#Some variables are deleted (rho>0.7)
#tm_min,bio3,bio5,bio7,bio11,bio13,bio14,bio15,bio16

##Step two

#Deleting variables with Spearman rho >= 0.7
No<-c("tm_min","bio3", "bio5", "bio7", "bio11","bio13","bio14","bio15","bio16")
No_id<-which(colnames(infossm_c)%in%No)
id<-c(15:37,45)
Si_id<-id[-which(id%in%No_id)]
infossmw<-infossm_c[,Si_id]

#Stepwise regression

FitStart<-lm(shannon_entropy ~ 1, data=na.omit(infossmw))
FitAll<-lm(shannon_entropy ~ ., data=na.omit(infossmw))
step(FitStart,direction = "both",scope = formula(FitAll))

#Model_1
lm1<-lm(formula = shannon_entropy ~ bio19 + pre + tm_max + elevation + 
          bio8 + bio12 + bio17 + bio1 + bio10 + bio18 + bio6 + bio2, 
        data = na.omit(infossmw))

##Step three

#Adding as fixed factors Family and Habitat (morphotype) and Study as random effects

lmm2.1_c<-lmer(formula = shannon_entropy ~ bio19 + pre + tm_max + elevation + 
                 bio8 + bio12 + bio17 + bio1 + bio10 + bio18 + bio6 + bio2 +
                 habitat + (1|Study) + Family, REML=F, data = na.omit(infossm_c))

#Cheking collinearity and deleting variables with VIF > 11 



tabla_VIF<-check_collinearity(lmm2.1_c)



write.csv(tabla_VIF, "table_VIF_lmm_29_07_2023.csv")


#Deleting variables bio1, bio10, bio6

lmm2.1_s<-lmer(formula = shannon_entropy ~ bio19 + pre + tm_max + elevation + 
                 bio8 + bio12 + bio17 + bio18 + bio2 +
                 habitat + (1|Study) + Family, REML=F, data = na.omit(infossm_c))



#Cheking collinearity again
tabla_VIF2<-check_collinearity(lmm2.1_s)


write.csv(tabla_VIF2, "table_VIF_lmm2_29_07_2023.csv")


#Comparing the two models

anova(lmm2.1_s, lmm2.1_c)



r.squaredGLMM(lmm2.1_c)
r.squaredGLMM(lmm2.1_s)

#The best model based on AIC was lmm2.1_s
save(infossm,lmm2.1_s, file = "model_data_29_07_2023.RData")

plot_model(lmm2.1_s, vline.color = "red")
