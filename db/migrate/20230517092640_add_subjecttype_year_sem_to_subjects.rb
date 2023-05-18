class AddSubjecttypeYearSemToSubjects < ActiveRecord::Migration[7.0]
  def change
    add_column :subjects, :subject_type, :integer, default: 0
    add_column :subjects, :year, :integer, default: 1
    add_column :subjects, :semester, :integer, default: 1

    add_index :subjects, :subject_type
    add_index :subjects, :year
    add_index :subjects, :semester
  end
end
