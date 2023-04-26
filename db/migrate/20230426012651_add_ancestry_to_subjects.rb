class AddAncestryToSubjects < ActiveRecord::Migration[7.0]
  def change
    add_column :subjects, :ancestry, :string
    add_index :subjects, :ancestry
  end
end
