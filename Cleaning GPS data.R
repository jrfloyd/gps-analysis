library(adehabitatHR)
library(spatstat)
library(trip)

clean<- function(file){
  setwd(paste0("C:/Users/Jessica/Desktop/dir_kenya_data/All_GPS_data/CSVs/"))
  host<-read.csv(file) 
  setwd(paste0("C:/Users/Jessica/Desktop/dir_kenya_data/All_GPS_data/Test stuff"))
  
  ids<-rep(1,times = length(host[,1]))                                 # One ID for all points
  timedate<-as.POSIXct(paste(host$Date, host$Time))
  obj<-data.frame(x=host[,3],y=host[,4],tms=timedate,id=ids)
  coordinates(obj)<-host[,3:4]
  proj4string(obj)<-CRS("+proj=longlat +ellps=WGS84")
  tr <- trip(obj, c("tms", "id"))
  
  tr$ok<-sda(tr,smax = 10,ang = c(10,90),distlim = c(0,0.01))  # filter out bad points
  summary(tr)
  
  #Make 'cleaned' csv file
  write.csv(host[which(tr$ok==T),],paste0("C:/Users/Jessica/Desktop/dir_kenya_data/All_GPS_data/Test stuff/",substr(file,1,8),"2.csv"))
}
file<-"Cow_21_tracker_17.csv"
clean("Cow_21_tracker_17.csv")
all_files<-list.files("C:/Users/Jessica/Desktop/dir_kenya_data/All_GPS_data/CSVs/")


tr$ok<-sda(tr,smax = 10,ang = c(0,90),distlim = c(0,0.05))


lapply(all_files,FUN = clean)