class Instructor < ApplicationRecord
  has_one :profile, as: :profileable, dependent: :destroy
  has_many :subject_schedules
  has_many :subjects, through: :subject_schedules
end
