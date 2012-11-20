class Contact < ActiveRecord::Base
  attr_accessible :invitee, :inviter

  belongs_to :user
  belongs_to :user

  validates :inviter, presence: true
  validates :invitee, presence: true
end
