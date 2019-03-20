class User < ApplicationRecord
  has_many :user_events
  has_many :events, through: :user_events


  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :phone, presence: true, format: { with: /\A\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*\z/, message: "Not a valid phone number" }
  validates :phone, uniqueness: true
  validates :username, uniqueness: true
end
