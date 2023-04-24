class Student < ApplicationRecord
  has_one :profile, as: :profileable, dependent: :destroy
  belongs_to :user, dependent: :destroy
  belongs_to :program
  has_many :admissions
  has_many :subject_schedules, through: :admissions

  accepts_nested_attributes_for :profile
  
  validates :program, presence: true

  searchable do
    integer :id
    text :program
    join(:name, :prefix => "student", :target => Profile, :type => :text, :join => { :from => :id, :to => :profileable_id })
    join(:email, :prefix => "student", :target => Profile, :type => :text, :join => { :from => :id, :to => :student_id })
  end

end
