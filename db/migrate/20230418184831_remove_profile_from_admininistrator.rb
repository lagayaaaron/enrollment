class RemoveProfileFromAdmininistrator < ActiveRecord::Migration[7.0]
  def change
    remove_column :administrators, :profile_id, :integer
    remove_column :administrators, :profile_type, :string
  end
end
