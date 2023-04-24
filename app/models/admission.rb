class Admission < ApplicationRecord
  belongs_to :student
  belongs_to :subject_schedule

  validates :student, :subject_schedule, presence: true

end
