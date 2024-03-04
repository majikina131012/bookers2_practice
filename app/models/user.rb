class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :books, dependent: :destroy       
  has_one_attached :profile_image
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  #自分がフォローした
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :followers, source: :followed
  
  #自分をフォローした
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_users, through: :followeds, source: :follower
  
  validates :name,length: { minimum: 2, maximum: 20 }, uniqueness: true
    
  validates :introduction,length: { maximum: 50 }
  
  def follow(user_id)
    followers.create(followed_id: user_id)
  end
  # ↑フォローするときの処理

  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end
  # ↑フォローを外す時の処理

  def following?(user)
    following_users.include?(user)
  end
  # ↑フォローしていればtrueを返す処理
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
end
