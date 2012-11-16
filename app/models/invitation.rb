class Invitation < ActiveRecord::Base
  attr_accessible :invitee, :inviter
  belongs_to :user

  before_save { |invitation| invitation.invitee = invitee.downcase }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :inviter, presence: true
  validates :invitee, presence: true, format: { with: VALID_EMAIL_REGEX }

end
