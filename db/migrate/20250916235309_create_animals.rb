class CreateAnimals < ActiveRecord::Migration[8.0]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :lhs_id
      t.integer :species, default: 0
      t.integer :gender, default: 0
      t.float :age
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
