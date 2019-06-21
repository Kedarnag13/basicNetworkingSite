require 'faker'

FactoryBot.define do
  factory :member do
    name { Faker::Name.name }
    original_url { "https://stackoverflow.com/" }
    email { Faker::Internet.email }
    password { 'Password@123' }
    password_confirmation { 'Password@123' }
  end
end
