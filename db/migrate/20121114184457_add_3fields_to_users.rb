class Add3fieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :phone_number, :string
    add_column :users, :description, :string
    add_index  :users, :email, unique: true
  end
end
