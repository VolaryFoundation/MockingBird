
ENV['RACK_ENV'] = 'test'

SPEC_ROOT = File.join(File.dirname(__FILE__))
require "#{SPEC_ROOT}/../app/boot"
require "#{SPEC_ROOT}/faker_extras.rb"

FactoryGirl.find_definitions

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods

  config.after(:each) do

    MongoMapper.database.collections.each do |collection|
      unless collection.name.match(/^system\./)
        collection.remove
      end
    end
  end

end
