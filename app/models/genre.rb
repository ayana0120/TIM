class Genre < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true, on: :update

  has_many :items, dependent: :delete_all
  belongs_to :user
end
