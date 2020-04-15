class Scraper

	def start
		get_song_hashes
	end

	def query_show(show)
		index_url = "https://www.tunefind.com"
		url_prefix = "https://www.tunefind.com/search/site?q="
		doc = Nokogiri::HTML(open(url_prefix + show))
		rows = doc.search(".tf-search-highlight")
		hashes = rows.collect do |row|
			{
				name: row.text,
				url: index_url + row['href']

			}
		end
	end

	def get_season_urls(url)
		# Get links to seasons
		# @index_url = 'https://www.tunefind.com/show/dark'
		# @series_doc = Nokogiri::HTML(open(@index_url))
		# @series_doc.search('.EpisodeListItem__title___32XUR').collect do |season|
		# 	@index_url.split('/show/').first + season.search('a').attribute('href').value
		# end
		index_url = 'https://www.tunefind.com/show/dark'
		series_doc = Nokogiri::HTML(open(url))
		series_doc.search('.EpisodeListItem__title___32XUR').collect do |season|
			url.split('/show/').first + season.search('a').attribute('href').value
		end
		# needs to return array with season URLS
	end

	def get_episode_urls(series_url)
		# receives array from #scrape_series
		#get links to episodes
		get_season_urls(series_url).collect do |season|
			doc = Nokogiri::HTML(open(season))
			episodes = doc.search(".EpisodeListItem__title___32XUR")
			ep_ids = episodes.collect do |ep|
				episode_id = ep.search('a').attribute('href').value.split('/').last
			end
			# returns arr of episode IDs
			link_arr = ep_ids.collect do |id|
				season + '/' + id
			end
		end.flatten
		# returns a 1-dimensional array of episode links for all seasons
	end

	def scrape_episodes(series_url)
		# get song tunefind song ids
		get_episode_urls(series_url).each do |url|
			doc = Nokogiri::HTML(open(url))
			song_ids = doc.search("a.SongTitle__link___2OQHD").collect do |song|
				song.attribute('href').value.split('/').last
			end
		end
		# should return an array of hashes
		# returns arr of spotify 'activator' links a la
		# https://www.tunefind.com/forward/song/137330?store=spotify&referrer=aHR0cHM6Ly93d3cudHVuZWZpbmQuY29tL3Nob3cvZGFyay9zZWFzb24tMS81NDgxOC9jZG4tY2dpL2FwcHMvYm9keS91cnJwN3F4bGxnLW81eHI1cTRfcTV1cGtqNWEuanM&x=q88asu&y=duq950wpilcgcw8048kog004os48kwo
		# 									  |id above|
	end

	def get_song_hashes(series_url)
		get_episode_urls(series_url).collect do |url|
			doc = Nokogiri::HTML(open(url))
			ep_song_hashes = doc.search("div.SongRow__container___3eT_L").collect do |song|
				tunefind_id = id_handler(song)
				{
					tunefind_id: tunefind_id,
					title: song.search('a').attribute('title').text,
					artist: song.search('.Subtitle__subtitle___1rSyh').text,
					episode_num: doc.search("div.EpisodePage__title___MiEq3 h1").text.split(" · ").first.split("E").last.to_i,
					episode_id: url.split('/').last.to_i,
					season: url.split('/')[-2].split("-").last.to_i
				}
			end
		end
	end

	def id_handler(song)
		id = song.search('a').attribute('href').value.split('/').reject(&:empty?)[1].to_i
		id > 0 ? id : song.search('a').attribute('href').value.split('/')[-3].to_i
	end

	def make_songs(series_url)
		get_song_hashes(series_url).flatten.each do |attrs|
			Song.new(attrs)
		end
	end

	def sel(url)
		driver = Selenium::WebDriver.for :chrome
		driver.get(url)
		buttons = driver.find_elements(:class, "StoreLinks__spotify___2k5Xi")
		urls = []
		# i want to click all of the buttons and get the spot.url in an array
		buttons.each do |button|
			button.click
			sleep(1)
			driver.switch_to.window(driver.window_handles.last)
			urls << driver.current_url
			driver.switch_to.window(driver.window_handles.first)
		end
		driver.quit
		urls

	end

	def spotify_ids_from_ep_page(url)
		# spotify uri format:
		# spotify:track:2wOAeV7IE1vxJDn6LsaywO
		prefix = "spotify:track:"
		urls = sel(url) #=> returns array of spotify URLS
		splits = urls.collect {|url| url.split("track")} #=> splits URL leaving /6BJXuY0lY0EUtSDCgkYnqE or :2wOAeV7IE1vxJDn6LsaywO
		to_trim = splits.collect {|split| split[1]}.reject {|id| id.nil?} #=> just keeps the code that i need (discards https://...etc)
		trimmed = to_trim.collect {|el| el[1..-1]}
		trimmed.collect {|raw| prefix + raw}
	end

	
	# for every episode link make me an array of spotify URIs
	def series_spot_ids(series_url)
		get_episode_urls(series_url).collect {|episode_url| spotify_ids_from_ep_page(episode_url)}.flatten.uniq
	end

	def series_song_count(series_url)

	end

 

end