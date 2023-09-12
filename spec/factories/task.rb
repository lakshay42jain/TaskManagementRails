FactoryBot.define do
  factory :task do
    title { Faker::Lorem.word }
    description { Faker::Lorem.word }
    due_date { Date.today + 7.days}
    priority { 1 }
    status { 1 }
    assignee_user_id { FactoryBot.create(:user).id  }
    assigner_user_id { FactoryBot.create(:user, role: 0).id  }
  end
end
