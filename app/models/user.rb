class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  rolify 

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, as: :profileable
  after_create :create_default_profile
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
