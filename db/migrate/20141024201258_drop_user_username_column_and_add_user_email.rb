class DropUserUsernameColumnAndAddUserEmail < ActiveRecord::Migration
  def change
    User.destroy_all

    remove_column :users, :username
    add_column :users, :email, :string

  end
end



