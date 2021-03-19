FactoryBot.define do
  factory :company do
    company_name { Faker::Lorem.characters(number: 10) }
    representative_name { Faker::Lorem.characters(number: 10) }
    phone_number { Faker::Lorem.characters(number: 10) }
    business_detail { Faker::Lorem.characters(number: 10) }
    employee_number { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    password { 'password' }
  end

  factory :noreview_company do
    company_name { "testcompany1" }
    representative_name { "testcompany1" }
    phone_number { 11100001111 }
    business_detail { "testcompany1" }
    employee_number { "testcompany1" }
    email { "test@gmail.com" }
    password { "testcompany1" }
  end
end
