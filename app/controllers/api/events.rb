require APP_ROOT + "/models/event"
require "#{APP_ROOT}/lib/calendar"

module SC
  module API
    class EventsController < ApiBaseController
    
      get "/" do
        ical = params.delete('ical')
        events = Event.search(params)
        if ical
          ical SC::Calendar.new(events)
        else
          ok events
        end
      end
      
      get "/:id" do
        event = Event.find(params[:id])
        if event
          ok event
        else
          missing
        end
      end
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
