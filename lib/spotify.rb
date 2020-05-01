CONFIG = {
  :access_token => "BQB6kaCw3--HAhG62lEIgPkD5JcFqhuHM2KT7ZzjwNjPyq1IZw0kxaCqzce73kb11P39Q4sMscEFUG52Z9pAS4Ub-z0Ff-YpBEanP-fAJVugNK8mmsH31lfX2Hams2LSAFcG2sA5gI53B4-_judcMA3MYLkySiWkyhaURmy4TValsTtchrR3riAInsXxBF9Ut_wJDvH8ZqyFE6nzP1tNxVEw7GJTvxbl8qFQtM404MrRL15DEAabTZF5D65Hq2sqBSvzrFCZE5DFvPuX",
  :raise_errors => true,  # choose between returning false or raising a proper exception when API calls fails

  # Connection properties
  :retries       => 0,    # automatically retry a certain number of times before returning
  :read_timeout  => 10,   # set longer read_timeout, default is 10 seconds
  :write_timeout => 10,   # set longer write_timeout, default is 10 seconds
  :persistent    => false # when true, make multiple requests calls using a single persistent connection. Use +close_connection+ method on the client to manually clean up sockets
}

