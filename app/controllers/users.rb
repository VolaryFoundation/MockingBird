require APP_ROOT + "/models/user"

module SC
  class UsersController < BaseController
  
    get "/new" do
      @user = User.new
      haml :"users/new"
    end
    
    put "/create" do
      @user = User.new(params[:user])
      if params[:user][:password] == params[:user][:password_confirmation]
        if @user.save
          session[:user_id] = @user.id
          flash[:notice] = "You have signup and have been logged in."
          redirect "../groups"
        else
          flash[:alert] = "User was unable to be created"
          haml :"users/new"
        end
      else
        flash[:alert] = "Password must match the confirmation"
        redirect "users/new"
      end
    end 
  end
end