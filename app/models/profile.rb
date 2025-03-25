class Profile < ApplicationRecord
  belongs_to :user
  
  validates :bio, length: { maximum: 1000 }
end