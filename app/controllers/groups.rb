require APP_ROOT + "/models/group"
require APP_ROOT + "/helpers/json_source_puller.rb"
require APP_ROOT + "/helpers/dynamic_attribute_helper.rb"

module SC
  class GroupsController < BaseController
  
    get "/" do
      @groups = JSON.parse(RestClient.get 'http://volary-eagle.herokuapp.com/groups', {:params => {:limit => 30, :page => 0}})
      haml :"groups/index"
    end
    
    get "/:id" do
      @eagle_group = JSON.parse(RestClient.get "http://volary-eagle.herokuapp.com/groups/#{params[:id]}")
      @eagle_group['props']['name'].each do |name|
        if @mb_group = Group.find_by_name(name['value'])
          break
        end
      end
      @meetup_group = (@eagle_group['refs'].has_key?('meetup') ? @meetup_group = source_puller('meetup', @eagle_group) : nil)
      @facebook_group = (@eagle_group['refs'].has_key?('facebook') ? @meetup_group = source_puller('facebook', @eagle_group) : nil)
      if @eagle_group.present? && @mb_group.present?
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
