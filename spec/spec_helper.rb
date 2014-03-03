
ENV['RACK_ENV'] = 'test'

SPEC_ROOT = File.join(File.dirname(__FILE__))
require "#{SPEC_ROOT}/../app/boot"
require "#{SPEC_ROOT}/support/faker_extras.rb"
require "#{SPEC_ROOT}/support/vcr.rb"
require "#{SPEC_ROOT}/support/login_helper.rb"

FactoryGirl.find_definitions

Capybara.app = Rack::Builder.parse_file(File.expand_path('../../config.ru', __FILE__)).first

RSpec.configure do |config|

  config.include Rack::Test::Methods
  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods

  config.after(:each) do

    MongoMapper.database.collections.each do |collection|
      unless collection.name.match(/^system\./)
        collection.remove
      end
    end
  end

end
