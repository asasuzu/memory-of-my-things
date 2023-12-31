class Report < ApplicationRecord
  belongs_to :user
  # polymorphic　1つのアソシエーション（関連付け）を複数のモデル間で共有する方法
  # reported_itemはPostモデルとCommentモデルに関連付いている。
  belongs_to :reported_item, polymorphic: true

  validates :reason, presence: true, length: { maximum: 400 }

  enum status: {
  waiting: 0,  # 対応待ち
  keep: 1,     # 保留
  finish: 2    # 対応済み
  }

  # reported_item_typeを日本語に変換するメソッド
  def reported_item_type_ja
    if reported_item_type == "Post"
      "投稿"
    elsif reported_item_type == "Comment"
      "コメント"
    end
  end

end
