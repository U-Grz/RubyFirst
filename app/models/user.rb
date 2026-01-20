class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
