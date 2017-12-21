class ReviewPost < ActiveRecord::Base
  belongs_to :user_admin
  belongs_to :category
end
