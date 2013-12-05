require './app/boot'

map "/events" do
  run SC::EventsController
end

map "/groups" do
  run SC::GroupsController
end
