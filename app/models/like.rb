class Like < ApplicationRecord
  # Associations
  belongs_to :post
  belongs_to :user

  # Callbacks
  after_save :update_post_likes_counter

  # Methods
  def update_post_likes_counter
    post.increment!(:likes_counter)
  end
end
