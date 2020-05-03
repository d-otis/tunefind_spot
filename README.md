# TV Show to Spotify Playlists
Easily take a TV show and compile a Spotify playlist with every song used in the show. No duplicates!

## Install Instructions
1. ```git clone``` this repo
1. ```bundle install``` gem dependencies
1. Create a ```credentials.rb``` file in your ```lib``` directory assigning constants to your Spotify login credentials. They must be ```EMAIL```, ```USER_ID```, and ```PASSWORD```. ```EMAIL``` is separated from ```USER_ID``` because Spotify secretly retains the first username you make and uses this as your primary key in their database when querying their API against your credentials. (be sure to ```.gitignore``` this file if you upload to a public repo!)

## Run
1. ```bin/tunefind_to_spotify``` to start
1. Search for the show
1. Select the show from the returned list (currently only supports shows and not movies)
1. Confirm continue when presented with song count (some of these shows can take awhile to get through!)
1. Wait for OAuth code to be obtained via ```Selenium Web Driver```
1. Select if you want to create a new playlist or add to existing.
1. Sit back and relax!
> You may encounter some errors with the ```selenium-webdriver``` business the first time your run as I did while using Chrome, just follow the prompts in the error messaging to make it work--fingers crossed! IE: I had to update my Chrome to the latest build.

## Notes
- Recently added the capability to add to existing Spotify playlists as opposed to creating new ones each time. I created this fix since the original functionality only made new playlists -- so many folks have asked me to run this from my account and I don't want to break the links for playlists if a new season of a show comes out and I need to add more songs. Ya heard?


