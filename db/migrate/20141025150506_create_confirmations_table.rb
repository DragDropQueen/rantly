class CreateConfirmationsTable < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.belongs_to :user, index: true
      t.string :token
      t.boolean :confirmed, default: false
    end

    add_column :users, :active, :boolean, default: false
  end
end
