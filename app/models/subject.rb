class Subject < ApplicationRecord
  belongs_to :program
  has_many :subject_schedules
  has_many :instructors, through: :subject_schedules
end
