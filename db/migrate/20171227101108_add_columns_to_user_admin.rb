class AddColumnsToUserAdmin < ActiveRecord::Migration
  def change
    add_column :user_admins, :email, :string
    add_column :user_admins, :password_token, :string
    add_column :user_admins, :reset_token, :string
  end
end
