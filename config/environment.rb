require 'bundler'
require 'open-uri'

Bundler.require

require_all 'lib'

# DB = {:conn => SQLite3::Database.new("db/songs.db")}