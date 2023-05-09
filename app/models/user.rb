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
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  #validation of course for student
  validates :course_id, presence: true, if: -> { is_student? }
  #For year and sem validations okay
  validates :year, :sem, presence: true, if: -> { is_student? && course_id.present? }

  searchable do
    integer :course_id
    text :email
    join(:name, :prefix => "profile", :target => Profile, :type => :text, :join => { :from => :profileable_id, :to => :id })
    join(:name, :prefix => "course", :target => Course, :type => :text, :join => { :from => :id, :to => :course_id })
    join(:code, :prefix => "course", :target => Course, :type => :string, :join => { :from => :id, :to => :course_id })
    # join(:name, :prefix => "profile", :target => Profile, :type => :text, :join => { :from => :id, :to => :profile_id, :include => { :profileable_type => "User" }})
    text :profile_name do
      profile.name if profile.present?
    end

  end

  def is_student?
    self.has_role?(:student)
  end

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize_to_fit: [50, 50]).processed 
    else
      "/default_profile.jpg"
    end
  end

end
