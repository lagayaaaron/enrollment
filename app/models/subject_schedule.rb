class SubjectSchedule < ApplicationRecord
  belongs_to :subject
  belongs_to :instructor
  validates :start_time, :end_time, :day_of_week, :location, presence: true
end
