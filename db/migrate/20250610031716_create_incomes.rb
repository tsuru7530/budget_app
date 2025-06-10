class CreateIncomes < ActiveRecord::Migration[8.0]
  def change
    create_table :incomes do |t|
      t.integer :district_id
      t.string :year
      t.string :category
      t.integer :price
      t.timestamps
    end
  end
end
