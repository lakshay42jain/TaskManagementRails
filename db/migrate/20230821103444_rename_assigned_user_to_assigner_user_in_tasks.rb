class RenameAssignedUserToAssignerUserInTasks < ActiveRecord::Migration[7.0]
  def change
    rename_column :tasks, :assigned_user_id, :assigner_user_id
  end
end
