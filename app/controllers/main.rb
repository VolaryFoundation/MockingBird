module SC
  class MainController < BaseController
    get "/" do
      redirect to('/groups')
    end
    
    get "/login" do ##new
      haml :"main/login"
    end
    
    put "/login" do
      user = User.authenticate(params[:user][:email], params[:user][:password])
      if user.present?
        session[:user_id] = user.id
        flash[:notice] = "You are now loged in"
        redirect "../groups"
      else
        flash[:alert] = "Invalid email or password"
        haml :"main/login"
      end
    end 
    
    delete "/logout" do
      session[:user_id] = nil
      flash[:notice] = "You are loged out"
      redirect "../groups"
    end
  end
end
