class User < ApplicationRecord
  rolify
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :profile, as: :profileable, dependent: :destroy


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true


  #STI Attribute
  self.inheritance_column = :type


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
