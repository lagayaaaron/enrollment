class Student < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one :profile, as: :profileable, dependent: :destroy

end
