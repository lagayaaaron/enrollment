class Administrator < User
  has_one :profile, as: :profileable, dependent: :destroy

end
