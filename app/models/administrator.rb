class Administrator < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one :profile, as: :profileable, dependent: :destroy

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :profile
end
