use Rack::Static, :urls => ['/stylesheets', '/javascripts', '/fonts', '/bower_components', '/images'], :root => 'public'
require './app/boot'

map "/" do
  run SC::BaseController
end

map "/api/events" do
  run SC::API::EventsController
end

map "/api/groups" do
  run SC::API::GroupsController
end

map "/events" do
  run SC::EventsController
end

map "/groups" do
  run SC::GroupsController
end
