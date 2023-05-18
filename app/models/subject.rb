class Subject < ApplicationRecord
  has_ancestry
  
  belongs_to :course

  has_many :subject_schedules
  has_many :instructors, through: :subject_schedules
  has_many :child_subjects, class_name: 'Subject', foreign_key: 'parent_id'

  enum subject_type: %w[Major Minor]
  enum year: %w[1st 2nd 3rd 4th]
  enum semester: %w[1st\ Sem 2nd\ Sem]

  validates :name, presence: true
  validates :code, presence: true, uniqueness: { scope: :name } #diff subjects can have the same name if diff code
  validates :year, presence: true
  validates :semester, presence: true
  validates :course, presence: true
  validates :subject_type, presence: true
  
  # accepts_nested_attributes_for :children, allow_destroy: true

end
