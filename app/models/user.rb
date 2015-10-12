class User < ActiveRecord::Base
	before_save {self.email = email.downcase}
	has_secure_password
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: {maximum: 50, minimum: 3}
	validates :email, presence: true, length: {maximum: 100, minimum: 4}, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}
	VALID_PASSWORD_REGEX = /\A(?=.{6, 30})(?=.[a-z])(?=.[A-Z])(?=.[\d\W]).*\z/
	validates :password, format: {with: VALID_PASSWORD_REGEX}
end
