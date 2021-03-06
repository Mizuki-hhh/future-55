FactoryBot.define do
  factory :user do
    role { 2 }
    name { Faker::Name.name }
    email { Faker::Internet.free_email }
    password = 'a1' + Faker::Internet.password(min_length: 4)
    password { password }
    password_confirmation { password }
    birthday { "1993-05-07" }
    occupation { Faker::Lorem.sentence }
    profile { 'test株式会社' }
  end
end
