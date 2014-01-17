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
