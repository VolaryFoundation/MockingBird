require "bundler/setup"

ENV['RACK_ENV'] = 'development' if ENV['RACK_ENV'].nil?
Bundler.require
Bundler.require(ENV['RACK_ENV'].to_sym)

ROOT = File.join(File.dirname(__FILE__), '..')
APP_ROOT = File.join(File.dirname(__FILE__))

require "#{ROOT}/env" 
require "#{ROOT}/env_personal" if File.exists?("#{ROOT}/env_personal.rb")

MongoMapper.connection = Mongo::MongoClient.from_uri(ENV['DATABASE_URL'])
db_name = ENV['DATABASE_URL'][%r{/([^/\?]+)(\?|$)}, 1]
MongoMapper.database = db_name


require "#{APP_ROOT}/controllers/base.rb"
require "#{APP_ROOT}/controllers/api/api_base.rb"
Dir["#{APP_ROOT}/controllers/api/*.rb"].each {|file| require file }
Dir["#{APP_ROOT}/controllers/*.rb"].each {|file| require file }
require "#{ROOT}/config/email.rb"
