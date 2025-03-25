class Watchlist < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :movies
  
  validates :name, presence: true
  validates :is_public, inclusion: { in: [true, false] }
end