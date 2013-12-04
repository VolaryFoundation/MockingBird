FactoryGirl.define do
  factory :location do
    address { Faker::Address.street_address } 
    country { Faker::Address.country }
    state { Faker::Address.state }
    city { Faker::Address.city }
    postal_code {Faker::Address.zip_code}
    lng_lat { [ Faker::Address.longitude.to_f, Faker::Address.latitude.to_f ] }
  end
end
