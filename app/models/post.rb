class Post < ApplicationRecord
  # Associations
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User'

  # Validations
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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
