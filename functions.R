pck_ <- c("tidyverse","rvest","stringr","rebus","lubridate","dplyr","here","xgboost", "data.table", "quantmod")

pck <- pck_[!(pck_ %in% installed.packages()[,"Package"])]
if(length(pck)){
  cat(paste0("Installing: ", pck, "\n"))
  install.packages(pck, repos = 'https://cran.rstudio.com/')
} # if you don't have these packages, install them all

suppressWarnings(suppressMessages(invisible(lapply(pck_, require, character.only = TRUE))))

getData <- function(url_){
  url_ <- "http://www.maxfm.com.tr/"
  #url_ <- url_
  html <- read_html(url_)
  
  attrbs <- html %>% html_nodes('#pastMusicList') %>% html_text() %>% str_trim() %>% unlist()
  
  attrbs <- gsub("\n","",attrbs)
  attrbs <- gsub("YAYINDA","",attrbs)
  attrbs <- gsub("( \\s{180,})", "::::", attrbs)
  attrbs <- strsplit(attrbs, "::::")[[1]]
  
  attrbs <- gsub("\\s{18,}",":::", attrbs)
  attrbs <- data.table(str_split_fixed(attrbs, ":::", 3))
  
  colnames(attrbs) <- c("Song", "Artist", "Genre")
  
  attrbs <- apply(attrbs, 2, str_to_title) %>% data.table()
  
  return(attrbs)
}
