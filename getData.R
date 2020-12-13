start_ <- Sys.time()

setwd("/path/to/maxfm") # path must be defined
source(paste0(getwd(),"/functions.R"))

# Run the commented out lines once. Then comment them out
# a <- getData("http://www.maxfm.com.tr/")
# write.table(file="plist.csv", a, sep = ",")

# Repeat every 5 mins
b <- rbind(read.csv(paste0(getwd(),"/plist.csv")), getData("http://www.maxfm.com.tr/"))
b <- b[!duplicated(b),]

write.table(file=paste0(getwd(),"/plist.csv"), b, sep = ",")
time_ <- Sys.time() - start_

paste0(Sys.time(), ": process successful and it took ", time_, " seconds.")
