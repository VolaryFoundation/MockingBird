module SC
  class BaseController < Sinatra::Base
    require APP_ROOT + "/models/user"
    require APP_ROOT + "/models/location"
    require APP_ROOT + "/models/tag"
    require APP_ROOT + "/models/link"
    require APP_ROOT + "/helpers/user_helper.rb"
    require 'rack-flash'
    
    enable :sessions
    set :session_secret, "something random"
    enable :method_override
    use Rack::Flash
    
    #Sets the default view under app/views
    set :views, APP_ROOT + '/views'
    
        
    def ok data
      status 200
      halt data
    end
    
    def no_post data
      status 500
      halt data
    end
  
    def missing
      status 404
      halt
    end
  end
end
