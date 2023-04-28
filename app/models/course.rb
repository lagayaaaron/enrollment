class Course < ApplicationRecord
    has_many :subjects, dependent: :destroy
    has_many :students
    
    validates :code, presence: true, uniqueness: true
    validates :name, presence: true
    validates :description, presence: true
end