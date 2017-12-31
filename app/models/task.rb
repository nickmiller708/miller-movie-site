class Task < ActiveRecord::Base
  belongs_to :progress
  belongs_to :owner, polymorphic: true
end
