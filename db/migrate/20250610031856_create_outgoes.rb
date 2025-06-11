class CreateOutgoes < ActiveRecord::Migration[8.0]
  def change
    create_table :outgoes do |t|
      t.integer :income_id
      t.string :year
      t.string :category
      t.integer :price
      t.string :memo
      t.timestamps
    end
  end
end
