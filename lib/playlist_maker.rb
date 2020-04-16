class PlaylistMaker

	attr_accessor :token, :playlist_id

	def add_tracks_to_playlist(ids, playlist_id)
		 user_id = 'danfoley85'
		 ids.each do |id|
		 	spotify_conn.add_user_tracks_to_playlist(user_id, playlist_id, id)
		 end
	end

	def spotify_conn()
		# token = "BQAU-SVrnNdHsCu2dDYUGyv5ZWy4xDO4x6brklGNw-EuikG932KfxzT-0SqoXxl8HIyXJHzD0bDgxLmq6pPuT0R-eh5pN6hmicJPm6HmUNMh5WdCA9_VqRj6Ws7Q9a1qAK9EJLiokF6U1Q7yl_l1A-IK-B_nR0Pbxw91H6ygXtMHXMvd2E25-2SP1YONLsl240CIDVx0ADlJwnJjzSYFtbwDp3D1eDCAxAR1EbVuth90j6aI-LNnI485ftrVyYdnU9DE2tgzy-JMYkrm"
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