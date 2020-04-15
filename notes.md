// Spotify_


1 - scrape show site to get season links
2 - scrape season pages to get episode links
3 - go to ep links and get song ids
then put that id in their proprietary url scheme
then grab their spotify track id in that response using doc.search('meta')[4].values[1].split('https://open.spotify.com/track/').last
then use that spotify track id to add track to spotify playlist

collect spotify URIs in an array then add them to playlist!

- deal with playlist track limit(100 tracks)
- check in with which sectors deal with song count (unique entries only)
- make using auth Token easier
- search for permanent solution to auth token
- connect track uri array to playlist creator
- create UI for entering show to search
- allow user to pick from show list results
- create playlist from commandline

