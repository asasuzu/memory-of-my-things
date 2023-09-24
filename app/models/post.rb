class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :flowers, dependent: :destroy
  has_many :reports, as: :reported_item

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 400 }

  enum spend_time: { unknown: 0, less_than_one_year: 1, one_to_three_years: 2, three_to_five_years: 3, five_or_more_years: 4 }

# 公開中の投稿を絞って、新着順にデータを取得
  scope :public_and_newest, -> { order(created_at: :desc).where(is_public: true) }

# 公開中の中からデータの検索（キーワードor過ごした期間）
  scope :search, ->(keyword, spend_time) {
    result = public_and_newest.where('title LIKE ? OR body LIKE ?', "%#{keyword}%", "%#{keyword}%")
    if spend_time.present?
      result = result.where(spend_time: spend_time)
    end
    result
  }

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  # 花むけ済みのユーザーかどうかを確かめる
  def flowered_by?(user)
  return false unless user
  flowers.where(user_id: user.id).exists?
  end

  # 通報済みの投稿かどうかを確かめる
  def already_reported_by?(user)
    return false unless user
    reports.exists?(user_id: user.id)
  end

end
