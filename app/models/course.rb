class Course < ApplicationRecord
    has_many :subjects, dependent: :destroy
    has_many :students
    
    validates :code, presence: true, uniqueness: true
    validates :name, presence: true
    validates :description, presence: true

    searchable do
        integer :id
        string :code
        text :name
    end

    state_machine :state, initial: :unpublished do
        event :publish do
            transition unpublished: :published
        end
        event :unpublish do
            transition publlished: :unpublished
        end
    end

end