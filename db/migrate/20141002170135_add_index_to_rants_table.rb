class AddIndexToRantsTable < ActiveRecord::Migration
  def change
    add_index :rants, :user_id
  end
end
