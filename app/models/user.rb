class User < ApplicationRecord
  # Associations
  has_many :post, foreign_key: 'author_id'
  has_many :comment
  has_many :like

  # Attributes
  attribute :name, :string
  attribute :bio, :text
  attribute :posts_counter, :integer, default: 0
  attribute :photo, :string

  # Methods
  def three_most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
