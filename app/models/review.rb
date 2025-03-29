class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_many :comments, dependent: :destroy
  
  validates :content, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  validates :user_id, uniqueness: { scope: :movie_id, message: "has already reviewed this movie" }
end