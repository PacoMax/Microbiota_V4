library("vegan")
library("phyloseq")


tabla_date<-read.csv("Super_table_27_07_22_V2_60.csv")
library(dplyr)       


tabla_date_c<-filter(tabla_date, Organism!="Cynops pyrrhogaster" | origin!="captive")





#
for(lvl in 2:7){
  
  abun<-read.csv(paste0("collapse/table-L",lvl,"_8_8_22.txt"), header = F, stringsAsFactors = FALSE,row.names=1,sep = "\t")
  abun<-abun[-1,]
  colnames(abun)<-abun[1,]
  abun<-abun[-1,]
  abun<-abun[-c(grep("__$", rownames(abun)),grep(";$", rownames(abun))),]
  
  
  
  
  tabla_date_c$Specie<-gsub("Pseudoeurycea sp. n. Mozotal 1","Pseudoeurycea sp.", tabla_date_c$Organism)
  
  
  
  sp<-unique(sort(tabla_date_c$Specie))
  
  
  for(i in sp){
    tmp<-tabla_date_c[which(tabla_date_c$Specie==i),]$Sample_id
    tmp2<-abun[,which(colnames(abun)%in%tmp)]
    tmp3<-apply(tmp2, 1,function(w){sum(as.numeric(w))/ncol(tmp2)})
    names(tmp3)<-rownames(tmp2)
    if(exists("cc")){
      cc<-cbind(cc,as.data.frame(tmp3))
    }else {cc<-as.data.frame(tmp3)}
  }
  colnames(cc)<-sp
  asp<-cc
  rm(cc)
  
  
  brayc<-vegdist(t(asp), method="bray", binary=FALSE, diag=FALSE, upper=FALSE, na.rm = T)
  jacc<-vegdist(t(asp), method="jaccard", binary=FALSE, diag=FALSE, upper=FALSE, na.rm = T)
  
  
  bm<-(as.matrix(brayc))
  jc<-(as.matrix(jacc))
  
  
  write.csv(file=paste0("Specie_bc_vegan_all_lvl_npc_",lvl,".csv"),bm)
  write.csv(file=paste0("Specie_jc_vegan_all_lvl_npc_",lvl,".csv"),jc)
  
}
