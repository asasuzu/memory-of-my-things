class Message < ApplicationRecord
  validates :message, presence: true, length: { maximum: 50 }

end
