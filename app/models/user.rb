class User < ApplicationRecord
  has_secure_password
  
  has_one :profile, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :watchlists, dependent: :destroy
  
  after_create :create_profile
  
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?
  validates :role, inclusion: { in: %w(admin user) }
  
  def admin?
    role == 'admin'
  end
  
  private
  
  def create_profile
    Profile.create(user: self)
  end
end