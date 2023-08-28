class TaskSerializer < ActiveModel::Serializer
  attributes :id, :description, :due_date, :priority , :status
end
