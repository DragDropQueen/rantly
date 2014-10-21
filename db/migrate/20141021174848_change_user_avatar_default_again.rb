class ChangeUserAvatarDefaultAgain < ActiveRecord::Migration
  def change
    change_column_default :users, :avatar, 'http://sw-rantly.s3.amazonaws.com/uploads/32a365f1-7cf4-4a76-9030-55bcef22b919/200.jpeg'
  end
end
