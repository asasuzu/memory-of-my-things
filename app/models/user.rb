class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :flowers, dependent: :destroy
  has_many :reports, dependent: :destroy
  validates :profile_image, blob: {content_type: ['image/jpeg', 'image/png', 'image/gif'], size_range: 1..10.megabytes }
  validates :name, presence: true, length: { maximum: 12 }

  # ユーザーが花むけした投稿を取得するメソッド
  def flowering_posts
    Post.joins(:flowers, :user)
        .where(flowers: { user_id: id })
        .where(users: { is_active: true })
        .where(posts: { is_public: true })
        .order('posts.created_at DESC')
  end

  # ゲストユーザーのメールアドレス
  GUEST_USER_EMAIL = "guest@example.com"

  # ゲストユーザーを作成するメソッド
  def self.create_guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.name = 'ゲストユーザー'
      user.password = SecureRandom.urlsafe_base64
    end
  end

  # ゲストユーザーかどうかを確認するメソッド
  def guest?
    email == GUEST_USER_EMAIL
  end

  # プロフィール画像を取得するメソッド
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default_user.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default_user.jpg', content_type: 'image/jpg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
