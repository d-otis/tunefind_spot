class CLI

	def start
		# query_result_hashes(get_search_term)
		search_term = get_search_term
		display_show_results(search_term)
		show_url = select_from_results(search_term)[:url]
		# Scraper.new.make_songs(show[:url])
		pl = PlaylistMaker.new
		pl.token = pl.get_token
		pl.create_playlist
		spotify_ids = Scraper.new.series_spot_ids(show_url)
		pl.make_playlist_from_ids(spotify_ids, pl.playlist_id)
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
		# allows use to select from display_show_results
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

end

