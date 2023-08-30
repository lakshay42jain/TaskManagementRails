FactoryBot.define do
  factory :user do
    email { 'user@email.com' }
    password { 'password' }
    role { 1 }
    phone_number { '1234512345' }
    name { 'name' }
    active { true }
  end
end
