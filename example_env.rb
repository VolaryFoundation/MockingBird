if ENV['RACK_ENV'] == 'test'
  ENV['DATABASE_URL'] = 'mongodb://localhost:27017/volary_api_test'
else
  ENV['DATABASE_URL'] = 'mongodb://localhost:27017/volary_api_development'
end