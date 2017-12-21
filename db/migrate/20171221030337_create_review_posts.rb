class CreateReviewPosts < ActiveRecord::Migration
  def change
    create_table :review_posts do |t|
      t.integer :user_admin_id
      t.integer :category_id
      t.text :contents
      t.text :title

      t.timestamps null: false
    end
  end
end
