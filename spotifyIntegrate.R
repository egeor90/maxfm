require(spotifyr)

get_playlist(playlist_id, fields = NULL, market = NULL,
             authorization = get_spotify_access_token())