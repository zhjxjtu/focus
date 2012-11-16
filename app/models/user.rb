class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :name, :phone_number, :description
  has_secure_password
  has_many :invitations, dependent: :destroy

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  before_save :create_verify_code

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end

    def create_verify_code
      self.verify_code = SecureRandom.urlsafe_base64
    end

end
