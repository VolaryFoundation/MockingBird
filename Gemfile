source 'https://rubygems.org'

ruby '2.0.0'

gem "sinatra"
gem "mongo_mapper", "0.13.0.beta2"
gem "bson_ext"
gem "icalendar"
gem "geocoder"
gem 'newrelic_rpm'
gem 'haml'
gem 'rack-flash3' #for session flash messages
gem 'rest-client'

group :development do
  gem "shotgun"
  ## Required for SASS
  gem 'sass'
  gem 'rb-fsevent', '~> 0.9'
  ## End Requirement for SASS
  gem 'debugger'
end

group :test do
  gem "rspec"
  gem "rack-test", require: "rack/test"
  gem "factory_girl"
  gem "faker"
end
