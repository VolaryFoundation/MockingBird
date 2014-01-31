require APP_ROOT + "/models/group"
require APP_ROOT + "/helpers/json_source_puller.rb"
require APP_ROOT + "/helpers/dynamic_attribute_helper.rb"
require APP_ROOT + "/helpers/abbreviation_helper.rb"

module SC
  class GroupsController < BaseController
  
    get "/" do
      if params[:state].present?
        begin
          @groups = JSON.parse(RestClient.get "#{ENV['EAGLE_SERVER']}groups?keys[location.state]=#{params[:state]}")
        rescue
          @group = nil
        end
      elsif params[:city].present?
        begin
          @groups = JSON.parse(RestClient.get "#{ENV['EAGLE_SERVER']}groups?keys[location.state]=#{params[:city]}")
        rescue
          @group = nil
        end
      else
        begin
          @groups = JSON.parse(RestClient.get "#{ENV['EAGLE_SERVER']}groups", {:params => {:limit => 30, :page => 0}})
        rescue
          @group = nil
        end
      end
      haml :"groups/index"
    end
    
    get "/map" do
      results = Geocoder.search(request.ip)
      state = (results.first.state.present? ? results.first.state : 'Colorado')
      @url = "http://volary-pigeon.herokuapp.com/groups-map.html?filters[subject]=groups&filters[keys][location.state]=#{abbreviate(state)}"
      haml :'groups/map'
    end
    
    get "/:id" do
      begin
        @eagle_group = JSON.parse(RestClient.get "#{ENV['EAGLE_SERVER']}groups/#{params[:id]}")
      rescue
        @eagle_group = nil
      end
      if @eagle_group.present?
        @mb_group = Group.find(@eagle_group['refs']['mockingbird']) 
        @meetup_group = (@eagle_group['refs'].has_key?('meetup') ? @meetup_group = source_puller('meetup', @eagle_group) : nil)
        @facebook_group = (@eagle_group['refs'].has_key?('facebook') ? @facebook_group = source_puller('facebook', @eagle_group) : nil)
      end
      if @eagle_group.present?
        haml :"groups/show"
      else
        haml "%h2 I am sorry but we cant find a group with the id: #{params[:id]}"
      end
    end
    
    post "/:id/claim" do
      group = Group.find(params[:id])
      user = current_user
      if user.present? && group.present?
        group.claim_group(user)
        flash[:notice] = "You have made a claim to this group. An admin will contact you soon via email."
        redirect back
      else
        flash[:notice] = "Unable to make the claim"
        redirect back
      end
    end
    
    post "/:id/approve" do
      if current_user.present? && current_user.role == 'admin'
        group = Group.find(params[:id])
        if group.present?
          group.approve_claim
          flash[:notice] = "Claim was approved. Dont forget to email the user to let them know."
          redirect back
        else
          flash[:notice] = "Unable to approve the claim"
          redirect back
        end
      else
        flash[:alert] = "You are not authrized to submit this command"
        redirect back
      end
        
    end
    
  end
end
