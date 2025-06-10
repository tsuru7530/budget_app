class CreateOutgoes < ActiveRecord::Migration[8.0]
  def change
    create_table :outgoes do |t|
      t.integer :district_id
      t.string :year
      t.string :category
      t.string :name
      t.integer :price
      t.timestamps
    end
  end
end
