require APP_ROOT + "/models/group"

module SC
  class GroupsController < BaseController
  
    get "/" do
      @groups = Group.all
      haml :"groups/index"
    end
    
    get "/:id" do
      @group = Group.find(params[:id])
      if @group.present?
        haml :"groups/show"
      else
        haml "%h2 I am sorry but we cant find a group with the id: #{params[:id]}"
      end
    end
  end
end
