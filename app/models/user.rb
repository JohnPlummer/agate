class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :encryptable, :validatable and :omniauthable
	devise :database_authenticatable, :registerable,
	       :recoverable, :rememberable, :trackable,
	       :confirmable, :lockable, :timeoutable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me

	validates_presence_of :username, :email, :password
	validates_uniqueness_of :username, :case_sensitive => false
	validates_size_of :username, :within => 2..20
	validates_size_of :password, :within => 6..20
	validates_confirmation_of :password

#	before_validation :save_display_username

	def to_s
		self.display_username
	end

	def username=(value)
		if (value != nil)
			self.display_username = value.clone
			value.downcase!
		end
		super
	end

	def username
		super
	end

	private

	def save_display_username
		if self.username != self.display_username.downcase
			self.display_username = self.username
		end
	end

end
