class Profile < ApplicationRecord
  belongs_to :profileable, polymorphic: true
  
  validates :name, :gender, :birthdate, :contact_number, :address, presence: true
  validates :email, presence: true, uniqueness: true

end
