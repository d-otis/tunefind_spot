require 'bundler'
require 'open-uri'

Bundler.require

require_all 'lib'

DB = {:conn => SQLite3::Database.new("db/songs.db")}

CONFIG = {
  :access_token => 'BQAGl0OqdVN2wSr_EWzmzouOSBnWTaHf0e7xgGLmSX5N_mpXBXPEr-gZhf89j1w-S5qwxgcwBmVtSkLqagjeiKJBTSvz4hJaPYW_vXddkyW8a6tiuofX7JiK3QUYYaO4oWDTrXexeLHYvBEiNFnEZEczt2OIW90yOvDcnbCQ42aWapR3lwVvQ7J7J_3C-iLyKDbya_TskJYijgGPvVVKOjuKEuztMlMKr0DKK9yr-R25hWxwTuMOFuihiznEyb40yDg6s0e8r2vMEGOt',  # initialize the client with an access token to perform authenticated calls
  :raise_errors => true,  # choose between returning false or raising a proper exception when API calls fails

  # Connection properties
  :retries       => 0,    # automatically retry a certain number of times before returning
  :read_timeout  => 10,   # set longer read_timeout, default is 10 seconds
  :write_timeout => 10,   # set longer write_timeout, default is 10 seconds
  :persistent    => false # when true, make multiple requests calls using a single persistent connection. Use +close_connection+ method on the client to manually clean up sockets
}

# S = Spotify::Client.new(CONFIG)



# BQBOp11Y0HtZmLAK76oYNwO5QmpDrk9vItrJosHZVq-7KPCnjY85pnW7E5Za0_-i2aeayRoiYVj6VjDLS6FNFbYhSviQTrMOAk5ZSmm7Jluy9r7bK5SiM6XZEklb7RFD6VVhjBmFnnN5Jvo3NlB2VuMtVOtab473_nB0ocZyBzi3YTdE-kzG42rY4hc-zM1B8GlNlERePIBDhUBWCS5ncWlJpXJfv6jKf92rZX45-po5eNIaWOpjZp5FKfej0FmqcGXr6h578fdnH2nj