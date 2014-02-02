class User
  
  include BCrypt
  include MongoMapper::Document
  
  many :group
  many :pending_claims, foreign_key: 'pending_user', class_name: 'Group'
  
  attr_accessible :email, :password, :password_confirmation
  attr_accessor :password, :password_confirmation
  
  before_validation :encrypt_password

  timestamps!
  key :email, required: true, unique: true
  key :password_hash, required: true
  key :password_salt, required: true
  key :role
  
  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
