# maxfm
Song integration from MaXfm into Spotify

## crontab
Job should work in the background from 5 to 10 mins of frequency. I recommend 10 minutes.

```sh
*/10 * * * * /usr/local/bin/Rscript "/path/to/getData.R"  >> "/path/to/getData.log" 2>&1
```
