class AddColumnToDistricts < ActiveRecord::Migration[8.0]
  def change
    add_column :districts, :image_delete, :integer
  end
end
