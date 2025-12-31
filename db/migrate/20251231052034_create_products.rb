class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.decimal :tax_percentage, precision: 5, scale: 2, default: 0.0
      
      t.timestamps
    end

    add_index :products, :name
  end
end
