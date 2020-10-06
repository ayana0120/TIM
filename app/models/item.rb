class Item < ApplicationRecord
  with_option presence: true do
  	validates :name
  	validates :quantity
  end

  belongs_to :user
end
