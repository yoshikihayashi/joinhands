FactoryBot.define do
  factory :project do
    association :company
    price { Faker::Lorem.characters(number: 10) }
    title { Faker::Lorem.characters(number: 10) }
    details { Faker::Lorem.characters(number: 30) }
  end
end
