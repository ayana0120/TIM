class Item < ApplicationRecord
  with_options presence: true do
  	validates :name
  	validates :quantity
  end

  belongs_to :genre
  belongs_to :user
  has_many :notifications
  attachment :image
end
