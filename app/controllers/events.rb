require APP_ROOT + "/models/event"
require "#{APP_ROOT}/lib/calendar"

module SC
  class EventsController < BaseController
  
    get "/" do
      @events = Event.all
      haml :"events/index"
    end
    
    get "/:id" do
      @event = Event.find(params[:id])
      if @event.present?
        haml :"events/show"
      else
        haml "%h2 I am sorry but we cant find a event with the id: #{params[:id]}"
      end
    end
    
     post "/:id" do
        @event = Event.find(params[:id])
        if @event.update_attributes(params[:event])
          flash[:notice] = "Your event has been updated"
          haml :"events/show"
        else
          @event.attributes = params[:event]
          flash[:alert] = "Failed to update event"
          haml :"events/show"
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
