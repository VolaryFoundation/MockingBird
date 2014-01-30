module SC
  class MainController < BaseController
    get "/" do
      redirect to('/groups')
    end

    
  end
end
