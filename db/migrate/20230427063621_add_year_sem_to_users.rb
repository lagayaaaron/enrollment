class AddYearSemToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :year_sem, :integer, array: true, default: [], limit: 2
  end
end
