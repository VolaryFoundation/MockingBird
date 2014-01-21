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
