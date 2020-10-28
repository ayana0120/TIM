class Item < ApplicationRecord
  with_options presence: true do
  	validates :name
  	validates :quantity
  end

  validate :name_valid?

  belongs_to :genre, optional: true
  belongs_to :user
  has_many :notifications
  attachment :image

  private

  def name_valid?
  	if genre.nil?
  		errors.add(:genre, "を選択してください")
  	end
  end

end
