class ReviewPost < ActiveRecord::Base
  belongs_to :user_admin
  belongs_to :category
  has_many :comments
  has_many :relevant_links
end
