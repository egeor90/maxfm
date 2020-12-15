require(spotifyr)
require(dplyr)

setwd("...") # define the working directory

Sys.setenv(SPOTIFY_CLIENT_ID = "...")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "...")

access_token <- get_spotify_access_token()

df <- read.csv("plist.csv")

for(i in 1:nrow(df)){
  data_ <- df[i,]
  epi <- search_spotify(q = tolower(paste0(as.character(data_[,1]), " ", as.character(data_[,2]))), type = "track",authorization = access_token)
  if(length(epi) > 0){
    epi <- epi[order(epi$popularity,decreasing = T),][1,]
    
    track_data <- get_track_audio_features(gsub("spotify:track:","",epi[,"uri"]), authorization = access_token)
    artist_id <- as.character((epi[,"artists"] %>% unlist() %>% as.data.frame())[2,])
    duration_ms <- as.numeric(epi[,"duration_ms"])
    expli <- epi[,"explicit"]
    popularity <- as.numeric(epi[,"popularity"])
    track_uri <- gsub("spotify:track:","",epi[,"uri"])
    album.release_date <- as.numeric(substr(as.character(epi[,"album.release_date"]),1,4))
    album_name <- epi[,"album.name"]
    album_id <- epi[,"album.id"]
    
    a <- data_ %>% bind_cols(album_name=album_name,
                        explicit=expli,
                        popularity=popularity,
                        album.release_date=album.release_date, 
                        track_data,
                        artist_id=artist_id,
                        album_id=album_id)
    
    key_note <- pitch_class_lookup[a$key + 1]
    mode_name <- ifelse(a$mode == 1,"major",ifelse(a$mode == 0, "minor", as.character(NA)))
    a$key_mode <- paste(key_note, mode_name)
    
    if(!exists("data_all")){
      data_all <- a
    }else{
      data_all[i,] <- a
    }
    
  }else{
    tmp_ <- bind_cols(df[i,],data.frame(t(rep(NA,25))))
    colnames(tmp_)[4:ncol(tmp_)] <- colnames(a)[4:ncol(a)]
    data_all[i,] <- tmp_
    next()
  }
}

write.table(data_all, "spotify_all.csv", col.names = TRUE, sep = ",")
