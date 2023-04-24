class CreateAdmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :admissions do |t|
      t.references :student, null: false, foreign_key: true
      t.references :subject_schedule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
