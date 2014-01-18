require APP_ROOT + "/models/group"
require 'debugger'

module SC
  module API
    class GroupsController < BaseController
    
      get "/" do
        ok Group.search(params)
      end
      
      get "/:id" do
        group = Group.find(params[:id])
        if group
          ok group
        else
          missing
        end
      end
      
      #patch "/:id" do
      #  group = Group.find(params[:id])
      #  if group.update_attributes(params[:group])
      #    ok group
      #  else
      #    group.attributes = params[:group]
      #    ok group
      #  end
      #end
    end
  end
end
