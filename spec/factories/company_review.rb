FactoryBot.define do
  factory :company_review do
    association :company
    rate { 2.5 }
  end
end