require_relative './config/environment'

def reload! 
	load_all './lib'
end

task :console do
	Pry.start
end

task :scrape do
	start = Scraper.new.make_songs
end

task :get_spot do
	spot_ids = PlaylistMaker.new.spotify_ids
end
