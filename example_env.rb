if ENV['RACK_ENV'] == 'test'
  ENV['DATABASE_URL'] = 'mongodb://localhost:27017/volary_api_test'
  ENV['EAGLE_SERVER'] = 'http://localhost:3000/'
else
  ENV['DATABASE_URL'] = 'mongodb://localhost:27017/volary_api_development'
  ENV['EAGLE_SERVER'] = 'http://localhost:3000/'
end