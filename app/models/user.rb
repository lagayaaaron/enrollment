class User < ApplicationRecord
  rolify
  has_one :profile, as: :profileable, dependent: :destroy
  #For course optional
  belongs_to :course, optional: true   
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :year, %W[1st 2nd 3rd 4th]
  enum :sem, %W[First Second]
  #STI Attribute
  self.inheritance_column = :type
  validates :email, uniqueness: true
  #validation of course for student
  validates :course_id, presence: true, if: -> { is_student? }
  #For year and sem validations okay
  validates :year, :sem, presence: true, if: -> { is_student? && course_id.present? }

  searchable do
    text :email
  end

  def is_student?
    User.has_role? (:student)
  end

end
