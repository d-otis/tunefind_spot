class Scraper

	def start
		get_song_hashes
	end

	def tunefind_scrape
		
	end

	def get_season_urls
		# Get links to seasons
		@index_url = 'https://www.tunefind.com/show/dark'
		@series_doc = Nokogiri::HTML(open(@index_url))
		@series_doc.search('.EpisodeListItem__title___32XUR').collect do |season|
			@index_url.split('/show/').first + season.search('a').attribute('href').value
		end
		# needs to return array with season URLS
	end

	def get_episode_urls
		# receives array from #scrape_series
		#get links to episodes
		season_urls = get_season_urls
		season_urls.collect do |season|
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

	def scrape_episodes
		# get song tunefind song ids
		episode_urls = get_episode_urls
		episode_urls.each do |url|
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

	def get_song_hashes
		episode_urls = get_episode_urls
		episode_urls.collect do |url|
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

	def make_songs
		get_song_hashes.flatten.each do |attrs|
			Song.new(attrs)
		end
	end


end