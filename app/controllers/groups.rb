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
    
    #post "/:id" do
    #  @group = Group.find(params[:id])
    #  if @group.update_attributes(params[:group])
    #    flash[:notice] = "Your group has been updated"
    #    haml :"groups/show"
    #  else
    #    @group.attributes = params[:group]
    #    flash[:alert] = "Failed to update group"
    #    haml :"groups/show"
    #  end
    #end
  end
end
