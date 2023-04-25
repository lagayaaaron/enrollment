class RenameProgramToCourse < ActiveRecord::Migration[7.0]
  def change
    rename_table :programs, :courses
  end
end
