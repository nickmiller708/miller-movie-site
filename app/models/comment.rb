class Comment < ActiveRecord::Base
  belongs_to :review_post
  validates :comment, length: {maximum: 250} 
end
