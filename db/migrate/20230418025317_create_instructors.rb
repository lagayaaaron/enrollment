class CreateInstructors < ActiveRecord::Migration[7.0]
  def change
    create_table :instructors do |t|
      t.references :user, foreign_key: true, unique: true
      t.references :profile, polymorphic: true, null: false

      t.timestamps
    end
  end
end
