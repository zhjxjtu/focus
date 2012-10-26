class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  before_save { |user| user.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  valitates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
