FactoryGirl.define do
  factory :link do
    url {Faker::Internet.url}
    name { Faker::Lorem.characters([10..150].sample) }
  end
end
