class Event < ApplicationRecord
  has_many :user_events
  has_many :users, through: :user_events


  validates :title, :start_time, :end_time, :description, presence: true
  validate :end_time_is_after_start_time

  before_save :set_completed

  def end_time_is_after_start_time
    return if end_time.blank? || start_time.blank?
    errors.add(:end_time, "cannot be before the start time") if end_time < start_time
  end


  def set_completed
    self.is_completed = true if end_time < Time.now
  end
end
