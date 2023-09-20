class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :reports, as: :reported_item

  validates :comment, presence: true, length: { maximum: 400 }
  
# 通報済みのコメントかどうかを確かめる
  def already_reported_by?(user)
    return false unless user
    reports.exists?(user_id: user.id)
  end

end
