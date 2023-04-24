class Student < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :program
  has_one :profile, as: :profileable, dependent: :destroy
  has_many :admissions
  has_many :subject_schedules, through: :admissions

  validates :program, presence: true

end
