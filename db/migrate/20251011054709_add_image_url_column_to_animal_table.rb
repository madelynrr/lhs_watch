class AddImageUrlColumnToAnimalTable < ActiveRecord::Migration[8.0]
  def change
    add_column :animals, :image_url, :string
  end
end
