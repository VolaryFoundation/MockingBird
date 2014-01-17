module SC
  class BaseController < Sinatra::Base
    require APP_ROOT + "/models/location"
    require APP_ROOT + "/models/tag"
    require APP_ROOT + "/models/link"
    
    set :views, APP_ROOT + '/views'
  
    def ok data
      status 200
      halt data
    end
  
    def missing
      status 404
      halt
    end
  end
end
