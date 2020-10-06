class Genre < ApplicationRecord
  validate :name, presence: true

  belongs_to :user
end
