class AddColumnDistricts < ActiveRecord::Migration[8.0]
  def change
      add_column :districts, :latitude, :float
      add_column :districts, :longitude, :float
  end
end
