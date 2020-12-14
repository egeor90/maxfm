options(warn=-1)
Sys.setlocale("LC_ALL", 'en_US.UTF-8')

require(spotifyr)
require(dplyr)

Sys.setenv(SPOTIFY_CLIENT_ID = "...")
Sys.setenv(SPOTIFY_CLIENT_SECRET = "...")

access_token <- get_spotify_access_token()
get_spotify_authorization_code(scope = "playlist-modify-public")

data_all <- read.csv("plist.csv")

for(i in 1:nrow(data_all)){
  
  data_ <- data_all[i,]
  epi <- search_spotify(q = tolower(paste0(as.character(data_[,1]), " ", as.character(data_[,2]))), type = "track",authorization = access_token)
  epi <- epi[order(epi$popularity,decreasing = T),]
  track_code <- as.character(epi[1,"uri"])
  
  data_all[i,"track_code"] <- track_code
}
  add_tracks_to_playlist(playlist_id = "...", # add playlist URI
                         uris = data_all$track_code)
