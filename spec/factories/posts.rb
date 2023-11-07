FactoryBot.define do
  factory :post do
    author { FactoryBot.create(:user) }
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph }
  end
end
