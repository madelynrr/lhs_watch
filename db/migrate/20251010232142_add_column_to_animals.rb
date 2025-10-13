class AddColumnToAnimals < ActiveRecord::Migration[8.0]
  def change
    add_column :animals, :favorite, :boolean, default: false, null: false
  end
end
