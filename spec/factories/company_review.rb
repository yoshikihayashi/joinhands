FactoryBot.define do
  factory :company_review do
    association :company
    rate { 2.5 }
    comment { Faker::Lorem.characters(number: 10) }
  end
end
