class AddNotNullConstraintsToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :email, false
    change_column_null :users, :name, false
    change_column_null :users, :phone_number, false
    change_column_null :users, :role, false
    change_column_null :users, :password, false
  end
end
