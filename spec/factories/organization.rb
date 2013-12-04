FactoryGirl.define do
  factory :group do
    name { Faker::Lorem.characters([10..150].sample) }
    description { Faker::Lorem.paragraph([3..10].sample) }
    size { Group::SIZE_OPTIONS.sample }
    range { Group::RANGE_OPTIONS.sample }
    tags { Faker::SC.tags }
    
    factory :group_with_loc do
       after(:build) do |org|
          org.location = FactoryGirl.create(:location)
       end
    end
    
    factory :group_with_links do
       after(:build) do |org|
         ([*2..5].sample).times do
           org.links << FactoryGirl.build(:link)
         end
       end
    end
    
  end
end


