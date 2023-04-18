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

  # after_create :create_default_profile
  # after_create :assign_default_role


  def create_default_profile
    create_profile(name: "Default Name", gender: "Unknown", email: self.email, birthdate: Date.today, contact_number: "", address: "")
  end

  def assign_default_role
    self.add_role(:student) if self.roles.blank?
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
