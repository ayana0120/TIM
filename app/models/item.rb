class Item < ApplicationRecord
  with_options presence: true do
  	validates :name
  	validates :genre_id
  	validates :quantity
  end

  belongs_to :genre
  belongs_to :user
  attachment :image
end
