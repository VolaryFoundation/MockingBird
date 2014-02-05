
ENV['RACK_ENV'] = 'test'

SPEC_ROOT = File.join(File.dirname(__FILE__))
require "#{SPEC_ROOT}/../app/boot"
require "#{SPEC_ROOT}/support/faker_extras.rb"
require "#{SPEC_ROOT}/support/vcr.rb"

FactoryGirl.find_definitions

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods
  config.extend VCR::RSpec::Macros
  
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.around(:each, :vcr) do |example|
     name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
     options = example.metadata.slice(:record, :match_requests_on).except(:example_group)
     VCR.use_cassette(name, options) { example.call }
   end

  config.after(:each) do

    MongoMapper.database.collections.each do |collection|
      unless collection.name.match(/^system\./)
        collection.remove
      end
    end
  end

end
