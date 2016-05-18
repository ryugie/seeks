class User < ActiveRecord::Base
	has_many :secrets
	has_many :likes, dependent: :destroy
	has_many :secrets_liked, through: :likes, source: :secret


	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :name, presence: true
	validates :password, presence: true, on: :create
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
	before_save do
		self.email.downcase!
	end
	has_secure_password
end


