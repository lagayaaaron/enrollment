class Profile < ApplicationRecord
  belongs_to :profileable, polymorphic: true

  before_validation :set_email_from_user, on: :create


  private

  def set_email_from_user
    self.email = profileable.email if email.blank? && profileable.present?
  end
end
