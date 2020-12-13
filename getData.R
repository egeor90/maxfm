start_ <- Sys.time()

setwd("/path/to/maxfm/") # path must be defined
source(paste0(getwd(),"/functions.R"))

if(!file.exists(paste0(getwd(), "/plist.csv"))){
  b <- getData("http://www.maxfm.com.tr/")
  write.table(file="plist.csv", b, sep = ",")
}else if(file.exists(paste0(getwd(), "/plist.csv"))){
  b <- rbind(read.csv(paste0(getwd(),"/plist.csv")), getData("http://www.maxfm.com.tr/"))
  b <- b[!duplicated(b),]
}else{
  print("Error!")
}

write.table(file=paste0(getwd(),"/plist.csv"), b, sep = ",")

time_ <- Sys.time() - start_
paste0(Sys.time(), ": process successful and it took ", time_, " seconds.")
