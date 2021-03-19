FactoryBot.define do
  factory :influencer_project do
    association :influencer
    association :project
    status { 0 }
    message { "testmessage" }
    influencer_message { "testinfluencer_message" }
  end
end
