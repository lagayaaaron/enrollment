class Program < ApplicationRecord
    has_many :students
    # has_many :courses
  
    validates :code, presence: true, uniqueness: true
    validates :name, presence: true
    validates :description, presence: true
end