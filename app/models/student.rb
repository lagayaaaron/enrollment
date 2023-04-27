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

  searchable do
    integer :id
    text :email
    # # join(:name, :prefix => "workshop", :target => Workshop, :type => :text, :join => { :from => :id, :to => :workshop_id })
    # join(:name, prefix: "profile", target: Profile, type: :text, join: { from: :id, to: :id})
    # join(:email, prefix: "profile", target: Profile, type: :text, join: { from: :id, to: :id})
    # # join(:student_id, prefix: "student", target: Profile, type: :text, join: { from: :id, to: :student_id })
    end

end
