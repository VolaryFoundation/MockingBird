module SC
  module API
    class BaseController < Sinatra::Base
      require APP_ROOT + "/models/location"
      require APP_ROOT + "/models/tag"
      require APP_ROOT + "/models/link"
    
      before do
        content_type :json
        headers['Access-Control-Allow-Origin'] = '*'
      end
    
      def ical data
        content_type :"text/calendar"
        status 200
        halt data.to_ical
      end
    
      def ok data
        status 200
        halt data.to_json
      end
    
      def missing
        status 404
        halt
      end
    end
  end
end
