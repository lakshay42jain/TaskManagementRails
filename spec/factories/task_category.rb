FactoryBot.define do
  factory :task_category do
    name { Faker::Lorem.word }
    description { Faker::Lorem.word }
  end
end
