require APP_ROOT + "/models/group"

module SC
  module API
    class GroupsController < ApiBaseController
    
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
      
      post "/:id" do
        debugger
        user = User.find(session[:user_id])
        @group = Group.find(params[:id])
        if user.present? && (@group.user == @user || user.role = 'admin')
          if params['group']['location'].present? 
            result = Geocoder.search(location_to_html(params[:group][:location])).first
            params[:group][:location][:lng_lat] = [result.longitude, result.latitude]
          end
          if @group.update_attributes(params[:group])
            ok @group.to_json
          else
            @group.attributes = params[:group]
            no_post @group.to_json
          end
        else
          no_save
        end
      end
    end
  end
end
