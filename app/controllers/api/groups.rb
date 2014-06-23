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

      post "/:id/delete" do
        user = User.find(session[:user_id])
        @group = Group.find(params[:id])
        if user.present? && (@group.user == @user || user.role = 'admin')
          @group.deleted = true
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


      post "/:id" do
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


      post "/:id/add_url" do
        user = User.find(session[:user_id])
        group = Group.find(params[:id])
        link = Link.new(params[:link])
        link.name = link.url
        if user.present? && (group.user == user || user.role = 'admin')
          if group.add_url(link)
            ok "[#{group.to_json},#{link.to_json}]"
          else
            debugger
            no_save group.to_json
          end
        else
          no_save
        end
      end

      post "/:group_id/url/:url_id" do
        user = User.find(session[:user_id])
        @group = Group.find(params[:group_id])
        link =  @group.links.find(params[:url_id])
        link.url = params[:link][:url]
        link.name = params[:link][:url]
        link.type = params[:link][:type]
        if user.present? && (@group.user == @user || user.role = 'admin')
          if link.save
            ok link.to_json
          else
            @group.attributes = params[:group]
            no_post @group.to_json
          end
        else
          no_save
        end
      end

      post "/:group_id/delete_url/:url_id" do
        user = User.find(session[:user_id])
        @group = Group.find(params[:group_id])
        link =  @group.links.find(params[:url_id])
        @group.links.delete_if{|l| l.id  == link.id}
        if user.present? && (@group.user == @user || user.role = 'admin')
          if @group.save
            ok link.to_json
          else
            # Figure out what to do for an error
          end
        else
          no_save
        end
      end

    end
  end
end

##=========================================================================##
## This file is part of MockingBird.                                       ##
##                                                                         ##
## MockingBird is Copyright 2014 Volary Foundation and Contributors        ##
##                                                                         ##
## MockingBird is free software: you can redistribute it and/or modify it  ##
## under the terms of the GNU Affero General Public License as published   ##
## by the Free Software Foundation, either version 3 of the License, or    ##
## at your option) any later version.                                      ##
##                                                                         ##
## MockingBird is distributed in the hope that it will be useful, but      ##
## WITHOUT ANY WARRANTY; without even the implied warranty of              ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU       ##
## Affero General Public License for more details.                         ##
##                                                                         ##
## You should have received a copy of the GNU Affero General Public        ##
## License along with MockingBird.  If not, see                            ##
## <http://www.gnu.org/licenses/>.                                         ##
##=========================================================================##
