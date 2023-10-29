class Book < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true,
    length: { maximum: 200 }
  
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def favorites_count_for_last_week
    # 過去一週間のいいね合計カウントを計算する
    last_week_start = 1.week.ago
    last_week_end = Time.current
    self.favorites.where(created_at: last_week_start..last_week_end).count
  end
end
