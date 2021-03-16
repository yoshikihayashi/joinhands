FactoryBot.define do
  factory :project do
    association :company
    price { "test1000" }
    title { "testtest" }
    details { "testproject" }
  end
  
end