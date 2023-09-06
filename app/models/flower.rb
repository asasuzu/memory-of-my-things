class Flower < ApplicationRecord
  belongs_to :user
  belongs_to :post
  # 1ユーザーが「1投稿」に対して「1花」という範囲を限定した一意チェック
  validates_uniqueness_of :post_id, scope: :user_id
end
