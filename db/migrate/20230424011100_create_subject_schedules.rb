class CreateSubjectSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :subject_schedules do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :instructor, null: false, foreign_key: true
      t.time :start_time
      t.time :end_time
      t.string :day_of_week
      t.string :location

      t.timestamps
    end
  end
end
