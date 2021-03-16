FactoryBot.define do
  factory :company do
    company_name { "testcompany1" }
    representative_name { "testcompany1" }
    phone_number { 11100001111 }
    business_detail { "testcompany1" }
    employee_number { "testcompany1" }
    email { "test@gmail.com" }
    password { "testcompany1" }
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