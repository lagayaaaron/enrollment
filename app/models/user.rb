class User < ApplicationRecord
  rolify
  has_one :profile, as: :profileable, dependent: :destroy
  #For course optional
  belongs_to :course, optional: true   
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar

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
    integer :course_id
    # integer :profileable_id
    text :email
    # join(:name, :prefix => "profile", :target => Profile, :type => :text, :join => { :from => :id, :to => :profileable_id })
    # join(:gender, :prefix => "profile", :target => Profile, :type => :string, :join => { :from => :id, :to => :profileable_id })
    join(:name, :prefix => "course", :target => Course, :type => :text, :join => { :from => :id, :to => :course_id })
    join(:code, :prefix => "course", :target => Course, :type => :string, :join => { :from => :id, :to => :course_id })

  end

  def is_student?
    self.has_role?(:student)
  end

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize_to_fit: [100, 100]).processed 
    else
      "/default_profile.jpg"
    end
  end

end
