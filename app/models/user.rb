class User < ApplicationRecord
  rolify
  serialize :year_sem, Array
  has_one :profile, as: :profileable, dependent: :destroy
  #For course optional
  belongs_to :course, optional: true   
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #STI Attribute
  self.inheritance_column = :type
  validates :email, uniqueness: true
  #validation of course for student
  validates :course_id, presence: true, if: -> { student? }
  #For year and sem validations okay
  validates :year_sem, presence: true, if: -> { student? && course_id.present? }

  def student?
    type == 'Student'
  end

end
