class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :posts, dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :post_comments, dependent: :destroy

  #フォローする、されるの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  #following_id=フォローするユーザー
  #followed_id =フォローされるユーザー
  
  #フォロー・フォロワーの一覧画面表示の記述
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :following
  
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  
  #active_notifications  = 自分からの通知
  #passive_notifications = 相手からの通知
  
  enum status: { nonreleased: 0, released: 1 }
  
  validates :email, presence: true, uniqueness: true
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :nickname, presence: true
  validates :introduction, length: { maximum: 100 }
  
  #フォローした時の処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  #フォローを外す時の処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  #フォローしているかどうか
  def following?(user)
    followings.include?(user)
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.family_name = "guest"
      user.first_name = "user"
      user.nickname = "ゲストユーザー"
    end
  end

  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  
  def self.search(keyword)
    if keyword
      User.where(["nickname like? OR email like? ", "%#{keyword}%", "%#{keyword}%"])
    else
      User.all
    end
  end
  
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(visited_id: id, action: 'follow')
      notification.save if notification.valid?
    end
  end

end
