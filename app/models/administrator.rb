class Administrator < User
  
  after_create :assign_role

  def assign_role
    add_role :administrator
  end
  
  def is_administrator?
    has_role?(:administrator)
  end

end
