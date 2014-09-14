class CreateRants < ActiveRecord::Migration
  def change
    create_table :rants do |t|
      t.integer :user_id
      t.text :rant
      t.string :title

      t.timestamps
    end
  end
end
