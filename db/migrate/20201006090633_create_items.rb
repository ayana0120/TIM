class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image_id
      t.integer :quantity
      t.date :exp
      t.text :memo
      t.integer :user_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
