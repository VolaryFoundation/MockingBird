require APP_ROOT + "/models/event"
require "#{APP_ROOT}/lib/calendar"

module SC
  module API
    class EventsController < BaseController
    
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
