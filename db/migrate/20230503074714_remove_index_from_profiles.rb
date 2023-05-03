class RemoveIndexFromProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_index :profiles, ["profileable_id", "profileable_type"], name: "index_profiles_on_profileable_id_and_profileable_type", unique: true
  end
end
