class Category < ActiveRecord::Base
  validates :category_name, uniqueness: true
  has_many :review_posts
end
