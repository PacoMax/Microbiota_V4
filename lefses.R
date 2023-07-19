#LEFSE

#Format R
#Change format for LEFSE input

abun<-read.csv("collapse/table-L4_8_8_22.txt", sep = "\t", header = F, stringsAsFactors = FALSE,row.names=1) #Read the taxonomy abundance table
abun<-abun[-1,] 
##delete first the header
colnames(abun)<-abun[1,]
abun<-abun[-1,]

infossm<-read.csv("Super_table_27_07_22_V2_60.csv") #Read super table (containing alfa diversities bioclimatic variables, especies, habitat and habitat, etc)


#Habitat<-unlist(sapply(as.vector(colnames(abun)), function(i){infossm[which(infossm$Sample_id==i),]$morphotype})) ##Option habitat
#x<-t(as.data.frame(Habitat))

Family<-unlist(sapply(as.vector(colnames(abun)), function(i){infossm[which(infossm$Sample_id==i),]$Family})) ##Option Family

x<-t(as.data.frame(Family))




row.names(abun)<-gsub("__","",row.names(abun))

row.names(abun)<-gsub(";","|",row.names(abun))

outersect <- function(x, y) {
  sort(c(setdiff(x, y),
         setdiff(y, x)))
}

samecols <- intersect(colnames(abun),colnames(x))

nop<-outersect(colnames(abun),colnames(x))



abun<-abun[ , -which(colnames(abun) %in% nop)]


abun2<-rbind(x,abun)


#write.table(abun2,file="feature-table_family_01_09_2022.txt", quote = F, col.names = F, row.names = T, sep = "\t") #Oprion Family


#write.table(abun2,file="feature-table_habiatat_01_09_2022_4.txt", quote = F, col.names = F, row.names = T, sep = "\t") #Option Habitat


##Lines in bash for lefse
#conda activate lefse_env ##python2.7

#lefse-format_input.py feature-table_habiatat_01_09_2022_4.txt feature-table_4_h.in -c 1 -s -1 -o 1000000

#run_lefse.py feature-table_4_h.in feature-table_4_h.res

#lefse-plot_res.py feature-table_4_h.res feature-table_4_h.svg --format svg

#lefse-format_input.py feature-table_family_01_09_2022_4.txt feature-table_4_h.in -c 1 -s -1 -o 1000000

#run_lefse.py feature-table_4_f.in feature-table_4_f.res

#lefse-plot_res.py feature-table_4_f.res feature-table_4_f.svg --format svg






#Heatmap example

###Habitat lefse

feature<-read.table("feature-table_habiatat_01_09_2022_4.txt", header = F, sep = "\t")
library(stringr)
lefse<-na.omit(read.table("feature-table_4_h_01_09_22.res", header = F, sep = "\t"))


lefse<-read.table("feature-table_family_01_09_2022.res", header = F, sep = "\t")

lefse<-lefse[which(as.numeric(lefse$V5)<0.05),] #p value, filter significant
lefse$LDA<-lefse$V4
lefse$Habitat<-lefse$V3







library(ggplot2)
library(ggthemes)
theme_Publication <- function(base_size=14, base_family="helvetica") {
  (theme_foundation(base_size=base_size, base_family=base_family)
   + theme(plot.title = element_text(face = "bold",
                                     size = rel(1.2), hjust = 0.5),
           text = element_text(),
           panel.background = element_rect(colour = NA),
           plot.background = element_rect(colour = NA),
           panel.border = element_rect(colour = NA),
           axis.title = element_text(face = "bold",size = rel(1)),
           axis.title.y = element_text(angle=90,vjust =2),
           axis.title.x = element_text(vjust = -0.2),
           axis.text = element_text(), 
           axis.line = element_line(colour="black"),
           axis.ticks = element_line(),
           panel.grid.major = element_line(colour="#f0f0f0"),
           panel.grid.minor = element_blank(),
           legend.key = element_rect(colour = NA),
           legend.position = "bottom",
           legend.direction = "horizontal",
           legend.key.size= unit(0.2, "cm"),
           legend.margin = unit(0, "cm"),
           legend.title = element_text(face="italic"),
           plot.margin=unit(c(10,5,5,5),"mm"),
           strip.background=element_rect(colour="#f0f0f0",fill="#f0f0f0"),
           strip.text = element_text(face="bold")
   ))
  
}

scale_fill_Publication <- function(...){
  discrete_scale("fill","Publication",manual_pal(values = c("#386cb0","#fdb462","#7fc97f","#ef3b2c","#662506","#a6cee3","#fb9a99","#984ea3","#ffff33")), ...)
  
}

scale_colour_Publication <- function(...){
  discrete_scale("colour","Publication",manual_pal(values = c("#386cb0","#fdb462","#7fc97f","#ef3b2c","#662506","#a6cee3","#fb9a99","#984ea3","#ffff33")), ...)
  
}

# change the factor levels so it will be displayed in correct order


lefse$V1 <- factor(lefse$V1, levels = as.character(lefse$V1))
lefse$Taxa<-gsub("\\.","\\|",lefse$V1)
feature$V1<-gsub("\\|\\|","\\|",feature$V1)


`%!in%` = Negate(`%in%`)



lefse_m<-lefse[which(lefse$Taxa%in%feature$V1),]

lefse_m<-lefse_m[order(lefse_m$LDA, decreasing = T),]
lefse_m<-lefse_m[order(lefse_m$Habitat, decreasing = T),]
lefse_m$Taxa<-factor(lefse_m$Taxa, levels = as.character(lefse_m$Taxa))
lefse_m2<-data.frame(Taxa=lefse_m$Taxa, Habitat=lefse_m$Habitat, LDA=lefse_m$LDA)





y<-c("Aquatic", "Terrestrial"  )  


feature_mo<-as.data.frame(lapply(feature[,-1][-1,],as.numeric))


feature_mo<-rbind(feature[1,-1],feature_mo)
feature_mo<-cbind(V1=feature$V1, feature_mo)




for(i in y){
  z<-as.data.frame(lapply(data.frame(feature_mo$V1,feature_mo[,which(i==feature_mo[1,])])[-1,][,-1],as.numeric))
  ww<-rowSums(z)/ncol(z)
  if(exists("nfeature")){
    nfeature<-cbind(nfeature,ww)
  }else{nfeature<-ww}
}

row.names(nfeature)<-feature_mo$V1[-1]
colnames(nfeature)<-y
nfeature<-as.data.frame(nfeature)


feature_m<-nfeature[which(rownames(nfeature)%in%lefse$Taxa),]

library("tidyr")

#lefse_m2<-separate(lefse_m2,Taxa,sep = "\\|", into = c("1","2","3","Taxa"))#For just plotting some taxa level


lefse_m2$Taxa<-factor(lefse_m$Taxa, levels = as.character(lefse_m$Taxa))


svg("lefses_Habitat.svg", width = 15, height = 17)
ggplot(lefse_m2, aes(x = Taxa, y = LDA)) +
  geom_bar(aes(fill = Habitat), stat = 'identity') +  # color by class
  coord_flip() +  # horizontal bars
  theme_Publication()
dev.off()


