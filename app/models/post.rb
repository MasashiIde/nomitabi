class Post < ApplicationRecord

  has_one_attached :shop_image

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def get_shop_image(width, height)
    unless shop_image.attached?
      file_path = Rails.root.join('app/assets/images/izakaya1.jpg')
      shop_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    shop_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.search(keyword)
    if keyword
      Post.where(["shop_name like? OR introduction like? OR shop_address like?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    else
      Post.all
    end
  end

end
