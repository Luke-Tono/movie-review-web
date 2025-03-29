class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_and_belongs_to_many :watchlists
  
  validates :title, presence: true
  validates :release_year, numericality: { only_integer: true, greater_than: 1900, less_than_or_equal_to: -> { Date.current.year } }, allow_nil: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  
  def average_rating
    reviews.average(:rating).to_f.round(1)
  end
end