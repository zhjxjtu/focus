class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :inviter
      t.integer :invitee

      t.timestamps
    end
    add_index :contacts, :inviter
    add_index :contacts, :invitee
    add_index :contacts, [:inviter, :invitee], unique: true
  end
end
