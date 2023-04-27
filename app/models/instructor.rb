class Instructor < User
  has_many :subject_schedules
  has_many :subjects, through: :subject_schedules

  after_create :assign_role 


  def assign_role
    add_role :instructor
  end

end
