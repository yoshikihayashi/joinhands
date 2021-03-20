FactoryBot.define do
  factory :influencer_project do
    association :influencer
    association :project
    status { 0 }
    message { Faker::Lorem.characters(number: 10) }
    influencer_message { Faker::Lorem.characters(number: 10) }
  end
end
