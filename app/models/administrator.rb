class Administrator < User
  has_one :profile, as: :profileable, dependent: :destroy
  
  after_create :assign_role


  def assign_role
    add_role :administrator
  end
end
