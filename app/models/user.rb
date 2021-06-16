class User < ApplicationRecord
  validates :email,{uniqueness: true}
  has_secure_password

  def posts
    return Post.where(user_id: self.id)
  end

end
