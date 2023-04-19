class Student < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :program
  has_one :profile, as: :profileable, dependent: :destroy

  validates :program, presence: true

end
