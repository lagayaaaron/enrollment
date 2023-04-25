class AddCourseReferenceToStudentsAndSubjects < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :course, foreign_key: true
    add_reference :subjects, :course, foreign_key: true
  end
end
