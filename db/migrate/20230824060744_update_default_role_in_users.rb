class UpdateDefaultRoleInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :role, from: nil, to: 1
  end
end
