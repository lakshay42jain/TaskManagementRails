class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone_number
      t.string :name
      t.integer :role
      t.string :password
      t.boolean :active

      t.timestamps
    end
  end
end
