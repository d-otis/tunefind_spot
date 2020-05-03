class CLI
	attr_accessor :pl, :scraper

	def start
		@scraper = Scraper.new
		search_term = get_search_term
		display_show_results(search_term)
		show_url = select_from_results(search_term)[:url]
		display_series_song_count(scraper, show_url)
		# is it too many songs? y/n
		input = gets.strip.downcase
		# if continue ask new-or-existing
		!['no', 'n'].include?(input) ? new_or_existing : goodbye
		# Would you like to make a new playlist?
		input = gets.strip.downcase
		# get and/or store token
		pl.token = scraper.auth_token

		!['no', 'n'].include?(input) ? make_playlist(scraper, show_url) : update_playlist(show_url, select_existing_playlist)
	end

	def pl
		@pl ||= PlaylistMaker.new
	end

	def scraper
		@scraper ||= Scraper.new
	end

	def get_search_term
		puts ""
		puts "Please Enter Show Query"
		puts ""
		show_query = gets.strip.downcase.gsub(" ", "+")
	end

	def query_result_hashes(search_term)
		 Scraper.new.query_show(search_term)
		 # returns an array of hashes for each result
	end

	def display_show_results(search_term)
		arr = query_result_hashes(search_term)
		arr.each.with_index(1) do |row, index|
			medium = row[:url].split("/")[-2].upcase
			puts "#{index}. #{row[:name]} - (#{medium})"
		end
		# prints a numbered list of results for user selection
	end

	def select_from_results(search_term)
		# allows user to select from display_show_results
		puts ""
		puts "Please Select a Show:"
		puts ""
		input = gets.strip.to_i
		index = input - 1
		query_result_hashes(search_term)[index]
		# returns hash of show selected...
		# {:name=>"It's Suppertime!", 
		# :url=>"https://www.tunefind.com/show/its-suppertime"}
	end

	def display_series_song_count(scraper, show_url)
		puts ""
		puts "There are #{scraper.series_song_count(show_url)} songs in this show."
		puts "Do you want to continue?"
		puts ""
	end

	def goodbye
		puts ""
		puts "Good bye"
		puts ""
	end

	def make_playlist(scraper, show_url)
		# pl ||= PlaylistMaker.new
		# pl.token = pl.get_token
		pl.create_playlist
		spotify_ids = scraper.series_spot_ids(show_url)
		pl.add_tracks_to_playlist(spotify_ids, pl.playlist_id)
		goodbye
	end

	def update_playlist(show_url, playlist)
		spotify_ids = scraper.series_spot_ids(show_url)
		pl.reject_duplicates(spotify_ids, pl.playlist_tracks(playlist))
		pl.add_tracks_to_existing_playlist(spotify_ids, playlist)
		goodbye
	end

	def list_user_playlists
		playlists = pl.user_playlists
		playlists.each.with_index(1) do |pl, index|
			puts "#{index}. #{pl[1]}"
		end
	end

	def select_existing_playlist
		playlists = pl.user_playlists
		list_user_playlists
		puts ""
		puts "Please select from an existing playlist: "
		puts ""
		input = gets.strip.to_i
		index = input - 1
		if index >= 0 && index <= playlists.size - 1
			puts "You have selected #{playlists[index][1]}"
			playlists[index][0]
		else
			puts ""
			puts "Invalid Input: Please enter a number between 1 and #{playlists.size}"
			puts ""
			sleep(2)
			select_existing_playlist
		end
		# returns selected_existing_playlist_id
	end

	def new_or_existing
		puts ""
		puts "Would you like to make a new playlist?"
		puts ""
	end
end

