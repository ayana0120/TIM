class Genre < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :delete_all
  belongs_to :user
end
