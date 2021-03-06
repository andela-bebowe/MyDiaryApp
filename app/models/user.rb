class User < ActiveRecord::Base
	attr_accessor :remember_token
	before_save {self.email = email.downcase}
	has_secure_password
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: {maximum: 50, minimum: 3}
	validates :email, presence: true, length: {maximum: 100, minimum: 4}, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end
	def forget
		update_attribute(:remember_digest, nil)
	end
end
