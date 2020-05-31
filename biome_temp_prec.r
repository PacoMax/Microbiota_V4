library(raster)

samples<-read.csv("SMS_persample.csv", header = T)

#read the samples file

samples$month<-formatC(samples$month, width = 2, format = "d", flag = "0")

#change format to the date

samples$tm_max<- rep("NA", nrow(samples))
samples$tm_min<- rep("NA", nrow(samples))
samples$pre<- rep("NA", nrow(samples))

start.time <- Sys.time()
for(i in 1:nrow(samples)){
  tryCatch({
    dat<-data.frame(samples$long[i], samples$lat[i])
    m=samples$month[i]
    y=samples$year[i]
    
    
    tif<-paste("Biogeocapas/wc2.1_2.5m_tmax_",y,"-",m,".tif", sep="")
    temp_a<-raster(tif)
    if(exists("temp_a")){samples$tm_max[i]<-extract(temp_a,dat)}
    rm(temp_a)
    
    tif2<-paste("Biogeocapas/wc2.1_2.5m_tmin_",y,"-",m,".tif", sep="")
    temp_i<-raster(tif2)
    if(exists("temp_i")){samples$tm_min[i]<-extract(temp_i,dat)}
    rm(temp_i)
    
    tif3<-paste("Biogeocapas/wc2.1_2.5m_prec_",y,"-",m,".tif", sep="")
    prec<-raster(tif3)
    if(exists("prec")){samples$pre[i]<-extract(prec,dat)}
    rm(prec)
    
  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
}
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

#extract climate variables (temp max, temp min, and precipitation) per month and year 


teow <- readOGR(dsn = "official", layer = "wwf_terr_ecos")

#readeing the data of terr_biomes


dat<-data.frame(sample.id=samples$sample.id,samples$long, samples$lat)

dat2<-na.omit(dat)

dat3<-data.frame(dat2$samples.long, dat2$samples.lat)

biomes<-extract(teow,dat3)

dat2$BIOME<-biomes$BIOME
dat2$ECO_NAME<-biomes$ECO_NAME

samples<-merge(samples,dat2, by="sample.id", all=T)

write.csv(samples,"Samples_biome_climate.csv", row.names = F, col.names = T)
