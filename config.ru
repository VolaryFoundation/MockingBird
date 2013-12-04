require './boot'

map "/events" do
  run SC::API::Events
end

map "/groups" do
  run SC::API::Groups
end
