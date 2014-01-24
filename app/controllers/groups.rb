require APP_ROOT + "/models/group"
require APP_ROOT + "/helpers/json_source_puller.rb"
require APP_ROOT + "/helpers/dynamic_attribute_helper.rb"
require APP_ROOT + "/helpers/abbreviation_helper.rb"

module SC
  class GroupsController < BaseController
  
    get "/" do
      if params[:state].present?
        @groups = JSON.parse(RestClient.get "#{ENV['EAGLE_SERVER']}groups?keys[location.state]=#{params[:state]}")
      elsif params[:city].present?
        @groups = JSON.parse(RestClient.get "#{ENV['EAGLE_SERVER']}groups?keys[location.state]=#{params[:city]}")
      else
        @groups = JSON.parse(RestClient.get "#{ENV['EAGLE_SERVER']}groups", {:params => {:limit => 30, :page => 0}})
      end
      haml :"groups/index"
    end
    
    get "/map" do
      results = Geocoder.search(request.ip)
      state = (results.first.state.present? ? results.first.state : 'California')
      @url = "http://volary-pigeon.herokuapp.com/groups-map.html?filters[subject]=groups&filters[keys][location.state]=#{abbreviate(state)}"
      haml :'groups/map'
    end
    
    get "/:id" do
      @eagle_group = JSON.parse(RestClient.get "#{ENV['EAGLE_SERVER']}groups/#{params[:id]}")
      @mb_group = Group.find(@eagle_group['refs']['mockingbird'])
      @meetup_group = (@eagle_group['refs'].has_key?('meetup') ? @meetup_group = source_puller('meetup', @eagle_group) : nil)
      @facebook_group = (@eagle_group['refs'].has_key?('facebook') ? @meetup_group = source_puller('facebook', @eagle_group) : nil)
      if @eagle_group.present?
        haml :"groups/show"
      else
        haml "%h2 I am sorry but we cant find a group with the id: #{params[:id]}"
      end
    end
    
  end
end
