class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :flowers, dependent: :destroy

  validates :title, presence: { message: "タイトルを入力してください" }
  validates :body, presence: { message: "本文を入力してください" }, length: { maximum: 200, message: "本文は200文字以内で入力してください" }

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def flowered_by?(user)
    flowers.exists?(user_id: user.id)
  end

end
