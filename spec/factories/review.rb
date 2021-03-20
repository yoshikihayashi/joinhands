FactoryBot.define do
  factory :review do
    association :influencer
    rate { 2.5 }
    comment { Faker::Lorem.characters(number: 10) }
  end
end
