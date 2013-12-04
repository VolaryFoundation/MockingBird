FactoryGirl.define do

  factory :event do
    name { Faker::Lorem.words(4).join(' ') }
    description { Faker::Lorem.paragraph([3..10].sample) }
    start_at {Faker::SC.time(2..4)}
    end_at {Faker::SC.time(5..7)}
    price {Event::PRICE_OPTIONS.sample}
    attendance {Event::ATTENDANCE_OPTIONS.sample}
    tags { Faker::SC.tags }
    factory :event_with_loc do
      after(:build) do |event|
         event.location = FactoryGirl.create(:location)
      end
    end
    
    factory :event_with_links do
       after(:build) do |event|
         ([*2..5].sample).times do
           event.links << FactoryGirl.build(:link)
         end
       end
    end
    
  end
end
