class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :auth_token, :string
    rename_column :users, :password, :password_digest
  end
end
