class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :reports, as: :reported_item

  validates :comment, presence: true, length: { maximum: 200 }
end
