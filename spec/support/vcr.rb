VCR.configure do |c|
  c.cassette_library_dir = "#{SPEC_ROOT}/vcr/cassettes"
  c.hook_into :fakeweb
  c.allow_http_connections_when_no_cassette = true
end