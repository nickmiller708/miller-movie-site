class CreateUserAdmins < ActiveRecord::Migration
  def change
    create_table :user_admins do |t|
      t.string :name
      t.string :username
      t.string :password

      t.timestamps null: false
    end
  end
end
