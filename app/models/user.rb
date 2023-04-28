class User < ApplicationRecord
  rolify
  has_one :profile, as: :profileable, dependent: :destroy
  #For course optional
  belongs_to :course, optional: true   
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :year, {first_year: 1, second_year: 2, third_year: 3, fourth_year: 4}
  enum :sem, {first_sem: 1, second_sem: 2}
  #STI Attribute
  self.inheritance_column = :type
  validates :email, uniqueness: true
  #validation of course for student
  validates :course_id, presence: true, if: -> { student? }
  #For year and sem validations okay
  validates :year, :sem, presence: true, if: -> { student? && course_id.present? }

  searchable do
    integer :id
    text :email
  end
  
  def student?
    type == 'Student'
  end

end
