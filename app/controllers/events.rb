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
  end
end
