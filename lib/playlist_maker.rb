class PlaylistMaker

	# 'https://www.tunefind.com/forward/song/19952?store=spotify&referrer=aHR0cHM6Ly93d3cudHVuZWZpbmQuY29tL3Nob3cvZGFyay9zZWFzb24tMS81NTE0NA&x=q88iaq&y=e74ejivnpvs4048cw84c8ko8ckskk08'

	def tunefind_ids
		Song.all.collect {|song| song.tunefind_id}
	end

	def spotify_ids
		arr = tunefind_ids.collect do |id|
			url = "https://www.tunefind.com/forward/song/#{id}?store=spotify&referrer=aHR0cHM6Ly93d3cudHVuZWZpbmQuY29tL3Nob3cvZGFyay9zZWFzb24tMS81NDgxOA&x=q89ugh&y=kxpa0k07fnk0socw4c4808w8sgcowwk"
			doc = Nokogiri::HTML(open(url))
			binding.pry
			get_spotify_id(doc)
		end
		
	end

	def get_spotify_id(doc)
		binding.pry
		doc.search('meta')[4].values[1].split('https://open.spotify.com/track/').last
	end

end

# need to spit out a list of Spotify track ids