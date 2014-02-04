require APP_ROOT + "/models/user"

module SC
  class PasswordResetController < BaseController
  
    get "/new" do
      @user = User.new
      haml :"password_reset/new"
    end
    
    put "/create" do
      @user = User.find_by_email(params[:user][:email])
      if @user.present?
        token = @user.request_reset_token
        @url = "#{request.host_with_port()}/password_reset/#{token}"
        Pony.mail(:to => @user.email, :subject => 'Password Reset Request', :body => haml(:'email/password_reset', layout: false))
        flash[:notice] = "Reset token has been sent"
        redirect "/"
      else
        flash[:alert] = "Email not found"
        redirect "password_reset/new"
      end
    end
    
    get "/:id" do
      @user = User.find_by_password_reset_token(params[:id])
      if @user.present?
        if @user.password_reset_expiration > Time.now
          haml :"password_reset/edit"
        else
          flash[:alert] = "Token has expired. Please try again"
          redirect "password_reset/new"
        end
      else
        flash[:alert] = "Token is not valid. Please try again"
        redirect "password_reset/new"
      end
    end
    
    put "/:id/update" do
      @user = User.find_by_password_reset_token(params[:id])
      if @user.present?
        if @user.password_reset_expiration > Time.now
          if params[:user][:password] == params[:user][:password_confirmation] 
            if @user.update_attributes(params[:user])
              #success
              session[:user_id] = @user.id
              @user.clear_token
              flash[:notice] = "You have changed your password and have been logged in."
              redirect "/"
            else
              #failed falied validation?
              flash[:alert] = "Password does not meet minimum requirments."
              redirect "/password_reset/#{params[:id]}"
            end
          else
            #failed confirmation mismatch
            flash[:alert] = "Password must match the confirmation"
            redirect "/password_reset/#{params[:id]}"
          end
        else
          #failed token expired
          @user.clear_token
          flash[:alert] = "Token has expired. Please try again"
          redirect '/password_reset/new'
        end
      else
        #failed user not found
        flash[:alert] = "Token is not valid. Please try again"
        redirect "password_reset/new"
      end
    end
  end
end