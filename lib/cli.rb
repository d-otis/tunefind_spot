class CLI

	def start
		scraper = Scraper.new
		search_term = get_search_term
		display_show_results(search_term)
		show_url = select_from_results(search_term)[:url]
		display_series_song_count(scraper, show_url)
		input = gets.strip.downcase
		if !['no', 'n'].include?(input)
			# Scraper.new.make_songs(show[:url])
			pl = PlaylistMaker.new
			pl.token = pl.get_token
			pl.create_playlist
			spotify_ids = scraper.series_spot_ids(show_url)
			pl.add_tracks_to_playlist(spotify_ids, pl.playlist_id)
		else
			goodbye
		end
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
end

