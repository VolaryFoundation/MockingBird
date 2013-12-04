
require 'spec_helper'

describe "Rake db:" do
  
  before do
    load File.expand_path("./Rakefile")
  end
  
  describe 'seed', :speed => 'slow' do
    it "should fill the database with test data" do
      Rake::Task["db:seed"].execute
      Group.first.should_not be_nil
    end
  end
  
  describe 'clear', :speed => 'slow' do
    it 'should remove all from the database' do
      FactoryGirl.create(:group_with_loc)
      FactoryGirl.create(:event_with_loc)
      Group.count.should be > 0
      Event.count.should be > 0
      Rake::Task["db:clear"].execute
      Group.count.should be == 0
      Event.count.should be == 0
    end
  end
end
