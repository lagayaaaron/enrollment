class AddYearSemToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :year, :integer, default: 1
    add_column :users, :sem, :integer, default: 1
  end
end
