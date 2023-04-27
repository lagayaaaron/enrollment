class User < ApplicationRecord
  rolify
  
  has_one :profile, as: :profileable, dependent: :destroy
  belongs_to :course, optional: true   
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true
  validates :course_id, presence: true, if: -> { type == 'Student' }

  #STI Attribute
  self.inheritance_column = :type

end
