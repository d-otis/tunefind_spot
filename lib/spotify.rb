config = {
  :access_token => 'BQDXfgz7ClzuhlnBX_S1ZGAU83Xpfj7MI5k1d1fDk0y4uWtSYHFQh32dUxyg91s__JFp5seu0__9y6b0jBZnMCCb5SghaHnAZk9KTSGkxGVBJe32N_-FH8_QGZ6s2MgyAoIOO7TQSuiLVDUatnG_q778II8LseQ5LBGpdkzY3g-beo5_6jId5aIaZCK5wJKWXwf2uNYNmu4Gi1tnT_ZwSm8bPxSrhfn2',  # initialize the client with an access token to perform authenticated calls
  :raise_errors => true,  # choose between returning false or raising a proper exception when API calls fails

  # Connection properties
  :retries       => 0,    # automatically retry a certain number of times before returning
  :read_timeout  => 10,   # set longer read_timeout, default is 10 seconds
  :write_timeout => 10,   # set longer write_timeout, default is 10 seconds
  :persistent    => false # when true, make multiple requests calls using a single persistent connection. Use +close_connection+ method on the client to manually clean up sockets
}

