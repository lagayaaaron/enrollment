class Course < ApplicationRecord
    has_many :subjects
    # has_many :courses
  
    validates :code, presence: true, uniqueness: true
    validates :name, presence: true
    validates :description, presence: true
end