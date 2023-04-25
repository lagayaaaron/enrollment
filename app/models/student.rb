class Student < User
  has_one :profile, as: :profileable, dependent: :destroy
  
  has_many :admissions
  has_many :subject_schedules, through: :admissions
  accepts_nested_attributes_for :profile

  after_create :assign_role

  def assign_role
    add_role :student
  end

  searchable do
    integer :id
    join(:name, :prefix => "student", :target => Profile, :type => :text, :join => { :from => :id, :to => :profileable_id })
    join(:email, :prefix => "student", :target => Profile, :type => :text, :join => { :from => :id, :to => :student_id })
  end

end
