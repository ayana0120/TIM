class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.integer :item_id, null: false
      t.integer :action

      t.timestamps
    end
  end
end
