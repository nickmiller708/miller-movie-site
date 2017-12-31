class CreateTaskBoards < ActiveRecord::Migration
  def change
    create_table :task_boards do |t|
      t.string :name
      t.references :owner, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
