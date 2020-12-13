start_ <- Sys.time()
source("/Users/Ege/Google Drive/ABROAD/University of Warsaw/Free Works/maxfm/functions.R")

# a <- getData("http://www.maxfm.com.tr/")
# write.table(file="plist.csv", a, sep = ",")

# Repeat every 5 mins
b <- rbind(read.csv("/Users/Ege/Google Drive/ABROAD/University of Warsaw/Free Works/maxfm/plist.csv"), getData("http://www.maxfm.com.tr/"))
b <- b[!duplicated(b),]

write.table(file="/Users/Ege/Google Drive/ABROAD/University of Warsaw/Free Works/maxfm/plist.csv", b, sep = ",")
time_ <- Sys.time() - start_

paste0(Sys.time(), ": process successful and it took ", time_, " seconds.")
