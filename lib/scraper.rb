class Scraper

	def start
		song_hashes
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

	def season_urls(url)
		#returns array with season URLS
		index_url = 'https://www.tunefind.com/show/dark'
		series_doc = Nokogiri::HTML(open(url))
		series_doc.search('.EpisodeListItem__title___32XUR').collect do |season|
			url.split('/show/').first + season.search('a').attribute('href').value
		end
	end

	def episode_urls(series_url)
		# returns a 1-dimensional array of episode urls for all seasons
		season_urls(series_url).collect do |season|
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
	end

	def song_hashes(series_url)
		# returns array of hashes to be used for instantiating new Song objects in memory and/or inserting to DB
		episode_urls(series_url).collect do |url|
			doc = Nokogiri::HTML(open(url))
			ep_song_hashes = doc.search("div.SongRow__container___3eT_L").collect do |song|
				{
					title: song.search('a').attribute('title').text,
					artist: song.search('.Subtitle__subtitle___1rSyh').text,
					episode_num: doc.search("div.EpisodePage__title___MiEq3 h1").text.split(" · ").first.split("E").last.to_i,
					episode_id: url.split('/').last.to_i,
					season: url.split('/')[-2].split("-").last.to_i
				}
			end
		end
	end

	def make_songs(series_url)
		song_hashes(series_url).flatten.each do |attrs|
			Song.new(attrs)
		end
	end

	def sel(url)
		driver = Selenium::WebDriver.for :chrome
		driver.get(url)
		buttons = driver.find_elements(:class, "StoreLinks__spotify___2k5Xi")
		urls = []
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

	def auth_token
		driver = Selenium::WebDriver.for :chrome
		driver.get("https://developer.spotify.com/console/get-playlists/")
		button = driver.find_element(:class => "btn-green")
		button.click
		sleep(1)
		checks = driver.find_elements(class: "control-indicator")
		checks.each {|check| check.click}
		submit = driver.find_element(id: "oauthRequestToken")
		submit.click
		sleep(1)
		driver.find_element(id: "login-username").send_keys(EMAIL)
		driver.find_element(id: "login-password").send_keys(PASSWORD)
		driver.find_element(id: "login-button").click
		sleep(1)
		oauth = driver.find_element(id: "oauth-input").property("value")
		driver.quit
		oauth
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

	def series_spot_ids(series_url)
		# returns an one-dimensional array of spotify uris for queried show (duplicates removed)
		episode_urls(series_url).collect {|episode_url| spotify_ids_from_ep_page(episode_url)}.flatten.uniq
	end

	def series_song_count(series_url)
		doc = Nokogiri::HTML(open(series_url))
		series_song_count = 0
		doc.search(".EpisodeListItem__container___3A-mL").each do |row|
			season_song_count = row.search("ul.list-unstyled li").last.text.split(" songs").join.to_i
			series_song_count += season_song_count
		end
		series_song_count
	end

 

end