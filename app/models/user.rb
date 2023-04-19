class User < ApplicationRecord
  rolify 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :student, dependent: :destroy
  has_one :instructor, dependent: :destroy
  accepts_nested_attributes_for :student
  accepts_nested_attributes_for :instructor


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_student_and_profile
  # after_create :create_instructor_and_profile

  # after_create :create_default_profile
  # after_create :assign_default_role
  def create_instructor_and_profile
    # Add the 'student' role to the user
    add_role(:instructor)

    # Create a new Student record associated with the user
    instructor = create_instructor

    # Create a new Profile record associated with the student
    instructor.create_profile(
      name: 'Default Ins Name',
      gender: 'Male',
      birthdate: Date.new(2000, 1, 1),
      contact_number: '1234567890',
      address: 'your address',
      email: self.email
    )
  end

  def create_student_and_profile
    # Add the 'student' role to the user
    add_role(:student)

    # Create a new Student record associated with the user
    student = create_student

    # Create a new Profile record associated with the student
    student.create_profile(
      name: 'Default Name',
      gender: 'Male',
      birthdate: Date.new(2000, 1, 1),
      contact_number: '1234567890',
      address: 'your address',
      email: self.email
    )
  end





  def is_student?
    has_role?(:student)
  end

  def is_instructor?
    has_role?(:instructor)
  end

  def is_administrator?
    has_role?(:administrator)
  end

end
