FactoryBot.define do
  factory :influencer do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    phone_number { Faker::Lorem.characters(number: 10) }
    address { Faker::Lorem.characters(number: 10) }
    nickname { Faker::Lorem.characters(number: 10) }
    follower_count { Faker::Lorem.characters(number: 5) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
