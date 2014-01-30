module SC
  class BaseController < Sinatra::Base
    require APP_ROOT + "/models/user"
    require APP_ROOT + "/models/location"
    require APP_ROOT + "/models/tag"
    require APP_ROOT + "/models/link"
    require 'rack-flash'
    
    enable :sessions
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
