class AddUserTypeToUserAdmin < ActiveRecord::Migration
  def change
    add_column :user_admins, :user_type, :string
  end
end
