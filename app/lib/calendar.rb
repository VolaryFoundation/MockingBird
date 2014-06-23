module SC
  class Calendar
    include Icalendar
    
    def initialize events
      @events = events 
      @cal = Calendar.new
      events.each do |e|
        @cal.event do
          dtstart     e.start_at
          dtend       e.end_at
          summary     e.name
          description e.description
        end
      end
    end
    
    def to_ical
      @cal.to_ical
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
