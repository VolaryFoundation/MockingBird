require APP_ROOT + "/models/group"

module SC
  class GroupsController < BaseController
  
    get "/" do
      @groups = Group.all
      haml :"groups/index"
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
