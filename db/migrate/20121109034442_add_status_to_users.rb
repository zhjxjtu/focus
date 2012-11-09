class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_status, :string, default: "new"
    add_column :users, :verify_code, :string
  end
end
