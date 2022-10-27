class User < ApplicationRecord
  MAX_LENGTH = 35
  MIN_LENGTH = 3

  validates :name, presence: true, length: { maximum: MAX_LENGTH }
  validates :photo, presence: true, length: { minimum: MIN_LENGTH }
  validates :bio, presence: true, length: { minimum: MIN_LENGTH }
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
