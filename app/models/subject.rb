class Subject < ApplicationRecord
  has_ancestry
  
  belongs_to :course
  has_many :subject_schedules
  has_many :instructors, through: :subject_schedules

end
