class Report < ApplicationRecord
  belongs_to :user
  # polymorphic　1つのアソシエーション（関連付け）を複数のモデル間で共有する方法
  # reported_itemはPostモデルとCommentモデルに関連付いている。
  belongs_to :reported_item, polymorphic: true

  validates :reason, presence: true, length: { maximum: 300 }

  enum status: {
  waiting: 0,  # 対応待ち
  keep: 1,     # 保留
  finish: 2    # 対応済み
  }



end
