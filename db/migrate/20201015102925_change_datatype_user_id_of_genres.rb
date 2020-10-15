class ChangeDatatypeUserIdOfGenres < ActiveRecord::Migration[5.2]
  def change
  	change_column :genres, :user_id, :string
  end
end
