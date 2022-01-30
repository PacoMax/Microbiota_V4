#Model


#Reading data

infossm<-read.csv("Super_table_ss_10_06_21.csv")
#centralizing the data
infossm[,c(15:37)]<-apply(infossm[,c(15:37)],2,function(x){scale(x, center = TRUE, scale = TRUE)})
#Log transfromations for evading right skew
infossm$faith_pd<-log(infossm$faith_pd)

#Step one
#Stepwise regression


infosslo<-infossm[,c(15:37,42)]


FitStart<-lm(faith_pd ~ 1, data=na.omit(infosslo))

FitAll<-lm(faith_pd ~ ., data=na.omit(infosslo))


step(FitStart,direction = "both",scope = formula(FitAll))





lmo2.1<-lm(formula = faith_pd ~ bio18 + tm_max + bio3 + bio1 + tm_min + 
             elevation + bio17 + bio10 + bio12 + bio14 + bio13 + bio19 + 
             bio9 + bio5 + pre, data = na.omit(infosslo))


#Step two

#Deleting variables with pearson coefficient >= .7


lmo2.1_a<-lm(formula = faith_pd ~ tm_max + pre + bio1 + bio3 + bio5 +
             bio9 + bio12 + bio17 + bio18 + bio19, 
           data = na.omit(infosslo))




#Step three

#Adding as fixed factors Family and Habitat and Study as random effects

infossm$habitat<-as.numeric(as.factor(infossm$morphotype))-1

lmm2.1_c<-lmer(formula = faith_pd ~ tm_max + pre + bio1 + bio3 + bio5 +
              bio9 + bio12 + bio17 + bio18 + bio19 +
              habitat + (1|Study) + Family, REML=F, data = na.omit(infossm))


#Cheking collinearity and deleting variables with VIF > 11 

library("performance")
check_collinearity(lmm2.1_c)


lmm2.1_s<-lmer(formula = faith_pd ~ tm_max + pre + bio1 + bio3 + bio5 +
               bio9 + bio17 + bio18 + bio19 + 
               habitat + (1|Study) + Family, REML=F, data = na.omit(infossm))



#Contrasting models

anova(lmm2.1_s, lmm2.1_c)


library("MuMIn")

r.squaredGLMM(lmm2.1_c)
r.squaredGLMM(lmm2.1_s)

save(infossm,lmm2.1_s, file = "model_data.RData")
