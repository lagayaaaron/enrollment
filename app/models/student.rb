class Student < User

  has_many :admissions
  has_many :subject_schedules, through: :admissions
  
  accepts_nested_attributes_for :profile
  after_create :assign_role

  def assign_role
    add_role :student
  end
  
  def is_student?
    has_role?(:student)
  end

end
