FactoryBot.define do
  factory :task do
    title { "title" }
    description { "description" }
    due_date { Date.today + 7.days}
    priority { 1 }
    status { 1 }
    assignee_user_id { nil }
    assigner_user_id { nil }
  end
end
