class User < ActiveRecord::Base
	has_many :restaurants
	has_many :reviews

	attr_accessor :password
	validates :email, :presence => true, :uniqueness => true
	validates :password, :confirmation => true #password_confirmation attr
	validates_length_of :password, :in => 6..20, :on => :create

	before_save :encrypt_password
	after_save :clear_password

	def encrypt_password
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.password_digest = BCrypt::Engine.hash_secret(password, salt)
		end
	end
	def clear_password
		self.password = nil
	end

	def authenticate password
		# @user.password == BCrypt::Engine.hash_secret(password, @user.salt)
		BCrypt::Password.new(self.password_digest) == password
	end
end
