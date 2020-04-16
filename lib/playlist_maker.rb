class PlaylistMaker

	attr_accessor :token, :playlist_id

	def add_tracks_to_playlist(ids, playlist_id)
		# from an array of spotify uris => 
		# add each, one by one, to playlist to avoid exceding API quota of 100 per request
		 user_id = 'danfoley85'
		 ids.each do |id|
		 	spotify_conn.add_user_tracks_to_playlist(user_id, playlist_id, id)
		 end
	end

	def spotify_conn()
		config = {
		  :access_token => @token,  # initialize the client with an access token to perform authenticated calls
		  :raise_errors => true,  # choose between returning false or raising a proper exception when API calls fails

		  # Connection properties
		  :retries       => 0,    # automatically retry a certain number of times before returning
		  :read_timeout  => 10,   # set longer read_timeout, default is 10 seconds
		  :write_timeout => 10,   # set longer write_timeout, default is 10 seconds
		  :persistent    => false # when true, make multiple requests calls using a single persistent connection. Use +close_connection+ method on the client to manually clean up sockets
		}
		client = Spotify::Client.new(config)
	end

	def get_token
		puts ""
		puts "Enter token from"
		puts "https://developer.spotify.com/console/post-playlist-tracks/"
		puts ""
		token = gets.strip
	end

	def create_playlist
		# returns playlist_id and sets instance variable of the same
		user_id = 'danfoley85'
		puts ""
		puts "Enter a Playlist Name"
		puts ""
		name = gets.strip
		new_playlist = spotify_conn.create_user_playlist(user_id, name, is_public = true)
		@playlist_id = new_playlist["id"]
	end
end