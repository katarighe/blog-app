FactoryBot.define do
    factory :user do
      name { Faker::Name.name }
      photo { Faker::Internet.url }
      bio { Faker::Lorem.sentence }
    end
  end