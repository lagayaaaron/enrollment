class Subject < ApplicationRecord
  has_ancestry
  
  belongs_to :course

  has_many :subject_schedules
  has_many :instructors, through: :subject_schedules

  validates :name, presence: true
  validates :code, presence: true, uniqueness: { scope: :name } #diff subjects can have the same name if diff code

end
