class RemoveProfileFromStudents < ActiveRecord::Migration[7.0]
  def change
    remove_column :students, :profile_id, :integer
    remove_column :students, :profile_type, :string
  end
end
