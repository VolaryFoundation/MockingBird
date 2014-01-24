require APP_ROOT + "/models/group"
require APP_ROOT + "/helpers/json_source_puller.rb"
require APP_ROOT + "/helpers/dynamic_attribute_helper.rb"

module SC
  class GroupsController < BaseController
  
    get "/" do
      @groups = JSON.parse(RestClient.get "#{ENV['EAGLE_SERVER']}groups", {:params => {:limit => 30, :page => 0}})
      haml :"groups/index"
    end
    
    get "/map" do
      results = Geocoder.search(request.ip)
      state = results.first.state
      debugger
      @url = "http://volary-pigeon.herokuapp.com/groups-map.html?filters[subject]=groups&filters[keys][location.state]=#{state}"
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
