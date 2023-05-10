class AddStateToCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :state, :string
  end
end
