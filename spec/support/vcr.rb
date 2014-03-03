VCR.configure do |c|
  c.cassette_library_dir = "#{SPEC_ROOT}/vcr/cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = false
end
