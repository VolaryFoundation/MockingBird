require APP_ROOT + "/models/user"

module SC
  class UsersController < BaseController
  
    get "/new" do
      @user = User.new
      haml :"users/new"
    end
    
    put "/create" do
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = "User was created"
        redirect "../groups"
      else
        flash[:alert] = "User was unable to be created"
        haml :"users/new"
      end
    end 
  end
end