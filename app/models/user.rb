class User < ApplicationRecord
  rolify 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true
  # after_create :create_student_and_profile


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
