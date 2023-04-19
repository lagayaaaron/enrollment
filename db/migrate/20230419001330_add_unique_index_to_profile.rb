class AddUniqueIndexToProfile < ActiveRecord::Migration[7.0]
  def change
    add_index :profiles, [:profileable_id, :profileable_type], unique: true
  end
end
