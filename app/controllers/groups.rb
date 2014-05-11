require APP_ROOT + "/models/group"
require APP_ROOT + "/helpers/json_source_puller.rb"
require APP_ROOT + "/helpers/dynamic_attribute_helper.rb"
require APP_ROOT + "/helpers/abbreviation_helper.rb"
require APP_ROOT + "/helpers/data_format_helper.rb"

module SC
  class GroupsController < BaseController
  
    get "/" do
      results = Geocoder.search(request.ip)
      state = (results.first.state.present? ? results.first.state : 'Colorado')
      @url = "#{ENV['WIDGET_SERVER']}groups-map.html?filters[subject]=groups&filters[keys][location.state]=#{abbreviate(state)}&size=645x600&viewMode=list"
      haml :"groups/index"
    end
    
    get "/map" do
      results = Geocoder.search(request.ip)
      state = (results.first.state.present? ? results.first.state : 'Colorado')
      @url = "#{ENV['WIDGET_SERVER']}groups-map.html?filters[subject]=groups&filters[keys][location.state]=#{abbreviate(state)}&size=645x600&viewMode=map"
      haml :'groups/map'
    end

    get "/new" do
      @group = Group.new()
      @group.location = Location.new(street_address: nil, street_num: nil, city: nil, state: nil, country: nil, postal_code: nil)
      haml :"groups/new"
    end

    post "/create" do
      @group = Group.new(params[:group])
      if params['group']['location'].present? && params['group']['location']['country'].present?
        @group.location = Location.new(params[:group][:location])
        result = Geocoder.search(location_to_html(params[:group][:location])).first
        @group.location.lng_lat = [result.longitude, result.latitude]
      end
      if @group.save
        flash[:notice] = "Your group has been created. Click edit fields here under the secular connect area to add more infromation or change current infromation"
        redirect "groups/#{@group.id}"
      else
        flash[:alert] = "Group was unable to be created. See below for detailed errors."
        haml :"groups/new"
      end
    end

    get "/:id" do
      if params['source'] == 'eagle'
        @mb_group = Group.find_by_eagle_id(params[:id])
      else
        @mb_group = Group.find(params[:id])
      end
      if @mb_group.present?
        if @mb_group.eagle_id.present?
          begin
            @eagle_group = JSON.parse(RestClient.get "#{ENV['EAGLE_SERVER']}cache/#{@mb_group.eagle_id}?type=group")
          rescue
            @eagle_group = nil
          end
        end
        if @eagle_group.present?
          @eagle_group['_refs'].each do |ref|
             @meetup_group = source_puller('meetup', @eagle_group) if ref['adapter'] == 'meetup'
             @facebook_group = source_puller('facebook', @eagle_group) if ref['adapter'] == 'facebook' 
          end
        end
        haml :"groups/show"
      else
        haml "%h2 I am sorry but we can not find a group with the id: #{params[:id]}"
      end
    end
    
    post "/:id/claim" do
      group = Group.find(params[:id])
      user = current_user
      if user.present? && group.present?
        group.claim_group(user)
        @url = "http://#{request.host}:#{request.port}/groups/#{group.id}"
        Pony.mail(:to => 'netops@volary.org', :subject => 'Group Ownership Claim', :body => haml(:'email/user_claim', layout: false))
        flash[:notice] = "You are attempting to claim this group. An admin will contact you via email as soon as possible."
        redirect back
      else
        flash[:notice] = "Unable to claim this group"
        redirect back
      end
    end
    
    post "/:id/approve" do
      if current_user.present? && current_user.role == 'admin'
        group = Group.find(params[:id])
        if group.present?
          group.respond_to_claim('approve')
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
