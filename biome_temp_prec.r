library(raster)
library("rgdal")
library("rgeos")

samples<-read.csv("SMS_persample.csv", header = T)
#Reading the sample information. The table have to be separated by "," with column names including "sample.id", "long", "lat", "month","year".
#where sample.id is the ID of the sample, long is the longitude and lat the latitude locations, month and year are the collection date.

#read the samples file

samples$month<-formatC(samples$month, width = 2, format = "d", flag = "0")

#change format to the date

samples$tm_max<- rep("NA", nrow(samples))
samples$tm_min<- rep("NA", nrow(samples))
samples$pre<- rep("NA", nrow(samples))


#Biogeocapas is an uncompress folder containing the worldclim data per month and elevation data (30s).  
#It is necessary to create the directory and download the data from: https://www.worldclim.org
#wget https://biogeo.ucdavis.edu/data/worldclim/v2.1/base/wc2.1_30s_elev.zip
#wget https://biogeo.ucdavis.edu/data/worldclim/v2.1/base/wc2.1_30s_bio.zip
#wget https://biogeo.ucdavis.edu/data/worldclim/v2.1/hist/wc2.1_2.5m_tmin_2010-2018.zip
#wget https://biogeo.ucdavis.edu/data/worldclim/v2.1/hist/wc2.1_2.5m_tmax_2010-2018.zip
#wget https://biogeo.ucdavis.edu/data/worldclim/v2.1/hist/wc2.1_2.5m_prec_2010-2018.zip
#official is an uncompress folder downloaded from https://www.worldwildlife.org/publications/terrestrial-ecoregions-of-the-world
#wget https://files.worldwildlife.org/wwfcmsprod/files/Publication/file/6kcchn7e3u_official_teow.zip?_ga=2.30019835.595585187.1657305484-1390015087.1657305484


start.time <- Sys.time()
for(i in 1:nrow(samples)){
  tryCatch({
    dat<-data.frame(samples$long[i], samples$lat[i])
    m=samples$month[i]
    y=samples$year[i]
    if(y>2018){y=2018}
    tif<-paste("Biogeocapas/wc2.1_2.5m_tmax_2010-2018/wc2.1_2.5m_tmax_",y,"-",m,".tif", sep="")
    temp_a<-raster(tif)
    if(exists("temp_a")){samples$tm_max[i]<-extract(temp_a,dat)}
    rm(temp_a)
    
    tif2<-paste("Biogeocapas/wc2.1_2.5m_tmin_2010-2018/wc2.1_2.5m_tmin_",y,"-",m,".tif", sep="")
    temp_i<-raster(tif2)
    if(exists("temp_i")){samples$tm_min[i]<-extract(temp_i,dat)}
    rm(temp_i)
    
    tif3<-paste("Biogeocapas/wc2.1_2.5m_prec_2010-2018/wc2.1_2.5m_prec_",y,"-",m,".tif", sep="")
    prec<-raster(tif3)
    if(exists("prec")){samples$pre[i]<-extract(prec,dat)}
    rm(prec)
    
  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
}

#extract climate variables (temp max, temp min, and precipitation) per month and year 

elevation<-raster("Biogeocapas/wc2.1_30s_elev/wc2.1_30s_elev.tif")

#reading the elevation data

dat<-data.frame(sample.id=samples$sample.id,samples$long, samples$lat)

dat2<-na.omit(dat)

dat3<-data.frame(dat2$samples.long, dat2$samples.lat)

dat2$elevation<-extract(elevation,dat3)

#extract elevation data

names_2<-rep("NA",19)

for(i in 1:19){
  bio<-paste("Biogeocapas/wc2.1_30s_bio/wc2.1_30s_bio_",i,".tif",sep="")
  names_2[i]<-paste("bio",i,sep="")
  bior<-raster(bio)
  dat2[,ncol(dat2)+1]<-extract(bior,dat3)
}
#reading and extracting the Bioclimatic variables

names_1<-c(colnames(dat2)[1:(ncol(dat2)-19)],names_2)

colnames(dat2)<-names_1

teow <- readOGR(dsn = "official", layer = "wwf_terr_ecos")

#reading the data of terr_biomes

biomes<-extract(teow,dat3)


dat2$BIOME<-biomes$BIOME
dat2$ECO_NAME<-biomes$ECO_NAME

samples<-merge(samples,dat2, by="sample.id", all=T)

write.csv(samples,"Samples_biome_climate.csv", row.names = F)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
