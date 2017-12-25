class Comment < ActiveRecord::Base
  belongs_to :review_post
end
