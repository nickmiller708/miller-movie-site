class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.string :name
      t.integer :progress

      t.timestamps null: false
    end
  end
end
