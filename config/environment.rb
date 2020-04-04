require 'bundler'
require 'open-uri'

Bundler.require

require_all 'lib'

DB = {:conn => SQLite3::Database.new("db/songs.db")}

CONFIG = {
  :access_token => 'BQDFATVhI_SW9uNnAAWzV8iI7myBdFdhQZvwrJ77xZ3efyxzER9CNBSBfCwNdq8i2ZCRL4ZbvSa5vYcctx819SC6lWyXcj6onuCoCb-d0IpwSShUMumlNMwjg5X117o6hc4GZ_vGluBfli9LxIYWiwzIU-dJYH6SngwitK-7XsqkJdg7K86DhBCVq0J5u4MIH7rzkEEDUXF5BP9xEHKyz-3MeUbX_ghuyUd5q4EjlGYZvMp0JmDDOTEFtuzEn-PACzvXEauap5VZgA',  # initialize the client with an access token to perform authenticated calls
  :raise_errors => true,  # choose between returning false or raising a proper exception when API calls fails

  # Connection properties
  :retries       => 0,    # automatically retry a certain number of times before returning
  :read_timeout  => 10,   # set longer read_timeout, default is 10 seconds
  :write_timeout => 10,   # set longer write_timeout, default is 10 seconds
  :persistent    => false # when true, make multiple requests calls using a single persistent connection. Use +close_connection+ method on the client to manually clean up sockets
}

SPOT = Spotify::Client.new(CONFIG)



