class Course < ApplicationRecord
    has_paper_trail
    
    has_many :subjects, dependent: :destroy
    has_many :students
    
    validates :code, presence: true, uniqueness: true
    validates :name, presence: true
    validates :description, presence: true
    
    searchable do
        integer :id
        string :code
        text :name
        string :state
    end

    state_machine :state, initial: :unpublished do
        event :publish do
            transition unpublished: :published
        end
        
        event :unpublish do
            transition any => :unpublished
        end
    end

end