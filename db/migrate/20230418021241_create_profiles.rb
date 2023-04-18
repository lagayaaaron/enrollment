class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :gender
      t.string :email
      t.date :birthdate
      t.string :contact_number
      t.text :address
      t.references :profileable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
