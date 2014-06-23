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
    
    def no_save data=''
      status 422
      halt data
    end
  
    def missing
      status 404
      halt
    end
  end
end

##=========================================================================##
## This file is part of MockingBird.                                       ##
##                                                                         ##
## MockingBird is Copyright 2014 Volary Foundation and Contributors        ##
##                                                                         ##
## MockingBird is free software: you can redistribute it and/or modify it  ##
## under the terms of the GNU Affero General Public License as published   ##
## by the Free Software Foundation, either version 3 of the License, or    ##
## at your option) any later version.                                      ##
##                                                                         ##
## MockingBird is distributed in the hope that it will be useful, but      ##
## WITHOUT ANY WARRANTY; without even the implied warranty of              ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU       ##
## Affero General Public License for more details.                         ##
##                                                                         ##
## You should have received a copy of the GNU Affero General Public        ##
## License along with MockingBird.  If not, see                            ##
## <http://www.gnu.org/licenses/>.                                         ##
##=========================================================================##
