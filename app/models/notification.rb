class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :item

  enum action: { warning: 1, expired: 2}
end
