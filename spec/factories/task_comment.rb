FactoryBot.define do
  factory :task_comment do
    body { 'body' }
    user_id { nil }
    task_id { nil }
  end
end
