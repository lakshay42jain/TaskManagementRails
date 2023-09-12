FactoryBot.define do
  factory :task_comment do
    body { Faker::Lorem.word }
    user_id { FactoryBot.create(:user).id  }
    task_id { FactoryBot.create(:task).id  }
  end
end
