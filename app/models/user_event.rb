class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :rsvp, presence: true
end
