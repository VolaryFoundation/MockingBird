
ENV['RACK_ENV'] = 'test'

#suggest to have respect return 1 if test fails
module Kernel
  alias :__at_exit :at_exit
  def at_exit(&block)
    __at_exit do
      exit_status = $!.status if $!.is_a?(SystemExit)
      block.call
      exit exit_status if exit_status
    end
  end
end


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
