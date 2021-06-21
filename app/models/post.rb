class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :user_id,{presence: true}
  validates :content,{presence: true}

  has_many :images

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def user
    return User.find_by(id: self.user_id)
  end

end
