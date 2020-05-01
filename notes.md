# TuneFind -> Spotify

- `bundle install` all dependencies
- change `user_id` to one of your choosing in `playlist_maker.rb` --> `#add_tracks_to_playlist`
- run in terminal by using `bin/tunefind_to_spotify`

## To-Do

1. Automate making new token and/or using client key/secret flow
1. ignore episode pages without any songs
1. generate play-by-play of songs being added to array?
1. allow for choosing an existing playlist (for ongoing shows)...in that case completely wipe the playlist and start over? or get an array of all the extant spot ids and check before adding new ones
