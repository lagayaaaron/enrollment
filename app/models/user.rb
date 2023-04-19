class User < ApplicationRecord
  rolify 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :student, dependent: :destroy
  has_one :instructor, dependent: :destroy
  has_one :administrator, dependent: :destroy
  accepts_nested_attributes_for :administrator
  accepts_nested_attributes_for :student
  accepts_nested_attributes_for :instructor


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_student_and_profile

  def create_student_and_profile
    # Add the 'student' role to the user
    add_role(:administrator)

    # Create a new Student record associated with the user
    admin = create_administrator
    # Create a new Profile record associated with the student
    admin.create_profile(
      name: 'Default Admin Name',
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
