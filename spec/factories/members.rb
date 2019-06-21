require 'faker'

FactoryBot.define do
  factory :member do
    name { Faker::Name.name }
    original_url { "https://stackoverflow.com/" }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { Faker::Internet.password }
  end
end
