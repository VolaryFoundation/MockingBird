if ENV['RACK_ENV'] == 'test'
  ENV['DATABASE_URL'] = 'mongodb://localhost:27017/grn_development'
else
  ENV['DATABASE_URL'] = 'mongodb://localhost:27017/grn_development'
end
