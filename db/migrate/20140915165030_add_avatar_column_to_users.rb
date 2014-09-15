class AddAvatarColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string, default: '200.jpeg'
  end
end
