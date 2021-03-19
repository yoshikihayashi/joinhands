FactoryBot.define do
  factory :review do
    association :influencer
    rate { 2.5 }
  end
end
