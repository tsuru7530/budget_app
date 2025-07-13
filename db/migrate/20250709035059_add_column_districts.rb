class AddColumnDistricts < ActiveRecord::Migration[8.0]
  def change
      add_column :districts, :latitude, :float
      add_column :districts, :longitude, :float
      add_column :districts, :image_delete, :integer
      add_column :districts, :address, :string
  end
end
