class User < ApplicationRecord
  rolify
  has_one :profile, as: :profileable, dependent: :destroy
  #For course optional
  belongs_to :course, optional: true   
  # Include default devise modules. Others available are:
  #  :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :confirmable, :lockable

  attr_writer :login

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

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  searchable do
    integer :id
    integer :course_id
    text :email
    join(:name, :prefix => "profile", :target => Profile, :type => :text, :join => { :from => :profileable_id, :to => :id })
    join(:gender, :prefix => "profile", :target => Profile, :type => :string, :join => { :from => :profileable_id, :to => :id })
    join(:name, :prefix => "course", :target => Course, :type => :text, :join => { :from => :id, :to => :course_id })
    join(:code, :prefix => "course", :target => Course, :type => :string, :join => { :from => :id, :to => :course_id })

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

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
  
end
