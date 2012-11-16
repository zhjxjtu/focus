class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :inviter
      t.string :invitee

      t.timestamps
    end

    add_index :invitations, [:inviter, :invitee], unique: true

  end
end
