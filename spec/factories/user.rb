FactoryGirl.define do
  factory :user do
    email 'user@example.com'
    password '!QAZxsw2'

    factory :admin do
      role 'admin'
    end
  end
end
