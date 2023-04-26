class RemoveCourseIdFromStudents < ActiveRecord::Migration[7.0]
  def change
    remove_reference :subjects, :program, null: false, foreign_key: true
  end
end
