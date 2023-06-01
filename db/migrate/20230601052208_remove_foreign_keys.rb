class RemoveForeignKeys < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :subject_schedules, :instructors
    remove_foreign_key :subject_schedules, :subjects
  end
end
