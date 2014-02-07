module SC
  module API
    class ApiBaseController < SC::BaseController
    
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
        return halt data.to_json if data
        halt
      end
    end
  end
end
