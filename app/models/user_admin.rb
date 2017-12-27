require 'bcrypt'
class UserAdmin < ActiveRecord::Base
 validates :username, :email, uniqueness: true
  has_many :review_posts
  before_create { generate_token(:password_token)} 
  before_update { generate_token(:password_token) if password_token.nil?}
  def valid_password?(password)
    BCrypt::Password.new(self.password) == password
  end 
  def encrypt_password(password)
    self.password =  BCrypt::Password.create(password)
  end   

  def generate_token(column)
    if self[column].nil?
    begin
      self[column] = SecureRandom.urlsafe_base64
    end  while UserAdmin.exists?(column => self[column])
    end 
  end
end
