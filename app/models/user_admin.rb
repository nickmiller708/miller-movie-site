require 'bcrypt'
class UserAdmin < ActiveRecord::Base
 validates :username, uniqueness: true
  has_many :review_posts
  def valid_password?(password)
    BCrypt::Password.new(self.password) == password
  end 
  def encrypt_password(password)
    self.password =  BCrypt::Password.create(password)
  end   
end
