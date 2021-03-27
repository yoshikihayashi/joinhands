FactoryBot.define do
  factory :company do
    company_name { Faker::Lorem.characters(number: 10) }
    representative_name { Faker::Lorem.characters(number: 10) }
    phone_number { Faker::Lorem.characters(number: 10) }
    business_detail { Faker::Lorem.characters(number: 10) }
    employee_number { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
