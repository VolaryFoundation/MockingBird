require "bundler/setup"

ENV['RACK_ENV'] = 'development' if ENV['RACK_ENV'].nil?
Bundler.require
Bundler.require(ENV['RACK_ENV'].to_sym)

ROOT = File.join(File.dirname(__FILE__), '..')
APP_ROOT = File.join(File.dirname(__FILE__))

require "#{ROOT}/env" if File.exists?("#{ROOT}/env.rb")

MongoMapper.connection = Mongo::MongoClient.from_uri(ENV['DATABASE_URL'])
db_name = ENV['DATABASE_URL'][%r{/([^/\?]+)(\?|$)}, 1]
MongoMapper.database = db_name

require "#{APP_ROOT}/controllers/api/base.rb"
Dir["#{APP_ROOT}/controllers/api/*.rb"].each {|file| require file }
require "#{APP_ROOT}/controllers/base.rb"
Dir["#{APP_ROOT}/controllers/*.rb"].each {|file| require file }
require "#{ROOT}/config/email.rb"
