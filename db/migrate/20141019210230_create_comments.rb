class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, show: true
      t.belongs_to :commented, show: true
      t.string :commented_type
      t.text :body

      t.timestamps
    end
  end
end
