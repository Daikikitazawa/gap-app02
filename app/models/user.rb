class User < ApplicationRecord
  validates :email,{uniqueness: true}

  def posts
    return Post.where(user_id: self.id)
  end
  
end
