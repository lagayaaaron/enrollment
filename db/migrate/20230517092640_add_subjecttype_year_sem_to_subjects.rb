class AddSubjecttypeYearSemToSubjects < ActiveRecord::Migration[7.0]
  def change
    add_column :subjects, :subject_type, :string, default: 'Major'
    add_column :subjects, :year, :string, default: '1st'
    add_column :subjects, :semester, :string, default: '1st Sem'

    add_index :subjects, :subject_type
    add_index :subjects, :year
    add_index :subjects, :semester

  end
end
