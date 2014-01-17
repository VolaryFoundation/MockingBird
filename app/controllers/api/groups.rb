require APP_ROOT + "/models/organization"

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
    end
  end
end
