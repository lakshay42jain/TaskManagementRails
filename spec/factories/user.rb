require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    role { 1 }
    phone_number { Faker::Number.number(digits: 10) }
    name { Faker::Name.name }
    active { true }
  end
end
