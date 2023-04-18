class RemoveProfileFromInstructor < ActiveRecord::Migration[7.0]
  def change
    remove_column :instructors, :profile_id, :integer
    remove_column :instructors, :profile_type, :string
  end
end
