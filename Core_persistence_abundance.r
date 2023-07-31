
tabla_date<-read.csv("Data_supertable.csv")

##Cores


for(lvl in 2:6){
  
  tryCatch({
    
    abun<-read.csv(paste0("collapse/table-L",lvl,"_25_07_2023.txt"), header = F, stringsAsFactors = FALSE,row.names=1,sep = "\t")
    abun<-abun[-1,]
    colnames(abun)<-abun[1,]
    abun<-abun[-1,]
    
    
    df_matrix<-as.matrix(sapply(abun, as.numeric))
    row.names(df_matrix)<-rownames(abun)
    df_matrix[df_matrix<=0] <- 0
    df_matrix[df_matrix>0] <- 1
    
    
    
    sp<-unique(sort(tabla_date$Specie))
    
    
    for(i in sp){
      tmp<-tabla_date[which(tabla_date$Specie==i),]$Sample.ID
      tmp2<-df_matrix[,which(colnames(abun)%in%tmp)]
      tmp3<-apply(tmp2, 1,function(w){sum(as.numeric(w))>0})
      names(tmp3)<-rownames(tmp2)
      if(exists("cc")){
        cc<-cbind(cc,as.data.frame(tmp3))
      }else {cc<-as.data.frame(tmp3)}
    }
    colnames(cc)<-sp
    asp<-cc
    rm(cc)
    
    
    
    df_matrix_asp<-as.matrix(sapply(asp, as.numeric))
    row.names(df_matrix_asp)<-rownames(asp)
    df_matrix_asp[df_matrix_asp<=0] <- 0
    df_matrix_asp[df_matrix_asp>0] <- 1
    
    tryCatch({core_70<-data.frame(Taxa=names(which(rowSums(df_matrix)*100/ncol(df_matrix)>=70)),core70=1)}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
    tryCatch({core_80<-data.frame(Taxa=names(which(rowSums(df_matrix)*100/ncol(df_matrix)>=80)),core80=1)}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
    tryCatch({core_90<-data.frame(Taxa=names(which(rowSums(df_matrix)*100/ncol(df_matrix)>=90)),core90=1)}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
    tryCatch({core_100<-data.frame(Taxa=names(which(rowSums(df_matrix)*100/ncol(df_matrix)>=100)),core100=1)}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
    
    library(dplyr)
    
    tryCatch({cores<-full_join(x = core_70, y = core_80, by = "Taxa")}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
    
    tryCatch({cores<-full_join(x = cores, y = core_90, by = "Taxa")}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
    
    tryCatch({cores<-full_join(x = cores, y = core_100, by = "Taxa")}, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
    
    write.csv(file=paste0("core_",lvl,"_25_07_2023.csv"),cores, row.names = F)
    
    rm(cores,core_100,core_70,core_80,core_90)
    
    
  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
}

##Persistence_abundance_occurrence


tabla_date<-read.csv("Super_table_26_07_2023.csv")
tabla_date$Specie<-gsub("Pseudoeurycea sp. n. Mozotal 1","Pseudoeurycea sp.", tabla_date$Organism)



for(lvl in 2:6){
  
  abun<-read.csv(paste0("New_data_meta_25072023/collapse/table-L",lvl,"_25_07_2023.txt"), header = F, stringsAsFactors = FALSE,row.names=1,sep = "\t")
  abun<-abun[-1,]
  colnames(abun)<-abun[1,]
  abun<-abun[-1,]
  
  
  
  
  
  
  spec<-unique(sort(tabla_date$Specie))
  
  
  for(i in spec){
    namesid<- tabla_date[which(tabla_date$Specie%in%i),]$Sample.ID
    y<-abun[,namesid]
    df1<-as.data.frame(lapply(y,as.numeric))
    w<-as.data.frame((rowSums(df1)/ncol(y))*100/2400)
    colnames(w)<-i
    ww<-as.data.frame(apply(df1,1,function(e){100-(sum(e%in%0)*100/length(e))}))
    colnames(ww)<-i
    www<-as.data.frame(apply(df1,1,function(e){sum(e%in%0)}))
    colnames(www)<-i
    if(exists("tabla1")){
      tabla1<-cbind(tabla1,w)
    }else{tabla1<-w}
    if(exists("tabla2")){
      tabla2<-cbind(tabla2,ww)
    }else{tabla2<-ww}
    if(exists("tabla3")){
      tabla3<-cbind(tabla3,www)
    }else{tabla3<-www}
  }
  
  row.names(tabla1)<-row.names(abun)
  row.names(tabla2)<-row.names(abun)
  row.names(tabla3)<-row.names(abun)
  
  write.csv(file=paste0("Persistencia_lvl_",lvl,"_27_07_2023.csv"),tabla2)
  
  write.csv(file=paste0("Abundancia_lvl_",lvl,"_27_07_2023.csv"),tabla1)
  
  write.csv(file=paste0("Persistencia_aparicion_lvl_",lvl,"_27_07_2023.csv"),tabla3)
  
  rm(tabla1,tabla2, tabla3)
  
}

