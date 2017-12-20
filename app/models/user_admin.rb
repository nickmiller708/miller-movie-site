class UserAdmin < ActiveRecord::Base
  validates :username, uniqueness: true
end
