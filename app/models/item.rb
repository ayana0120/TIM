class Item < ApplicationRecord
  with_options presence: true do
  	validates :name
  	validates :quantity
  end

  belongs_to :user
end
