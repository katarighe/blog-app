class Comment < ApplicationRecord
  # Associations
  belongs_to :post
  belongs_to :user
  after_save :update_post_comments_counter

  # Methods
  def update_post_comments_counter
    post.increment!(:comments_counter)
  end
end
