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
          flash[:notice] = "You have signed up and are now logged in."
          redirect "../groups"
        else
          flash[:alert] = "Unable to sign you up"
          haml :"users/new"
        end
      else
        flash[:alert] = "Password must match the confirmation password"
        redirect "users/new"
      end
    end 
  end
end
