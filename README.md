# TV Show to Spotify Playlists
Easily take a TV show and compile a Spotify playlist with every song used in the show. No duplicates!

## Install Instructions
1. ```git clone``` this repo
1. ```bundle install``` gem dependencies
1. You'll want to replace the ```user_id``` with yours.
1. ```bin/tunefind_to_spotify``` to start
1. You may encounter some errors with the ```selenium-webdriver``` business as I did while using Chrome, just follow the prompts in the error messaging to make it work--fingers crossed!

## Notes
- Recently added the capability to add to existing Spotify playlists as opposed to creating new ones each time. I created this fix since the original functionality only made new playlists -- so many folks have asked me to run this from my account and I don't want to break the links for playlists if a new season of a show comes out and I need to add more songs. Ya heard?

### To Do
1. Automate Auth token generation
