FactoryBot.define do
  factory :task_task_category do
    task_id { FactoryBot.create(:task).id  }
    task_category_id { FactoryBot.create(:task_category).id  } 
  end
end
