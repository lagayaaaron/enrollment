class RemoveCodeColumnFromSubjects < ActiveRecord::Migration[7.0]
  def change
    remove_column :subjects, :code, :string
  end
end
