class RemoveProgramReferenceToSubject < ActiveRecord::Migration[7.0]
  def change
    remove_column :subjects, :program_id, :integer
  end
end
