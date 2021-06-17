class User < ApplicationRecord
  validates :email,{uniqueness: true}
  has_secure_password

  has_many :posts,dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  def posts
    return Post.where(user_id: self.id)
  end

end
