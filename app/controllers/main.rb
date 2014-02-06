module SC
  class MainController < BaseController
    require 'uri'
    
    get "/" do
      redirect to('/groups')
    end
    
    get "/login" do ##new
      session[:request_url] = request.referer
      haml :"main/login"
    end
    
    post "/login" do
      user = User.authenticate(params[:user][:email], params[:user][:password])
      if user.present?
        session[:user_id] = user.id
        flash[:notice] = "You are now loged in"
        redirect (session[:request_url] || '/')
      else
        flash[:alert] = "Invalid email or password"
        redirect back
      end
    end 
    
    delete "/logout" do
      session[:user_id] = nil
      flash[:notice] = "You are loged out"
      uri = URI::parse(request.referer).path
      ok uri.to_json
      #redirect "../groups"
    end
  end
end