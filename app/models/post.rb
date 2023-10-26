class Post < ApplicationRecord
  # Associations
  has_many :comment
  has_many :like
  belongs_to :author, class_name: 'User'

  # Callbacks
  after_save :update_user_posts_counter

  # Methods
  def update_user_posts_counter
    author.increment!(:posts_counter)
  end

  def five_most_recent_comments
    Comment.where(post_id: id).order(created_at: :desc).limit(5)
  end
end
