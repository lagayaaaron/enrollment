class CreatePrograms < ActiveRecord::Migration[7.0]
  def change
    create_table :programs do |t|
      t.string :code
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
