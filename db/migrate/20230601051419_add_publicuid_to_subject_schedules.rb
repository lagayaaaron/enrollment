class AddPublicuidToSubjectSchedules < ActiveRecord::Migration[7.0]
  def change
    add_column :subject_schedules, :public_uid, :string
    add_index :subject_schedules, :public_uid
  end
end
