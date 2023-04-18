class Profile < ApplicationRecord
  belongs_to :profileable, polymorphic: true
  
  validates :name, :gender, :birthdate, :contact_number, :address, presence: true
  validates :email, presence: true, uniqueness: true

  before_validation :set_email_from_user, if: -> { email.nil? && profileable_type == 'User' }

  private

  def set_email_from_user
    self.email = profileable.email
  end
end
