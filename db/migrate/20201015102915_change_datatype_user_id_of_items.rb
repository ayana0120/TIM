class ChangeDatatypeUserIdOfItems < ActiveRecord::Migration[5.2]
  def change
  	change_column :items, :user_id, :string
  end
end
