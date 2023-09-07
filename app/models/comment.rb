class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comment, length: { minimum: 1, maximum: 100, message: "コメントは1文字から100文字までです" }
end
