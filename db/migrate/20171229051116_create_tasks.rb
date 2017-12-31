class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.references :progress, index: true, foreign_key: true
      t.references :owner, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
