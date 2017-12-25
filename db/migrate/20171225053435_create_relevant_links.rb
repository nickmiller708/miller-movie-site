class CreateRelevantLinks < ActiveRecord::Migration
  def change
    create_table :relevant_links do |t|
      t.references :review_post, index: true, foreign_key: true
      t.string :title
      t.string :source
      t.string :link_type

      t.timestamps null: false
    end
  end
end
