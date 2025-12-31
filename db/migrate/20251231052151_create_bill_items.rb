class CreateBillItems < ActiveRecord::Migration[5.0]
  def change
    create_table :bill_items do |t|
      t.references :bill, foreign_key: true
      t.references :product, foreign_key: true

      t.integer :quantity, null: false, default: 1

      t.decimal :rate, precision: 10, scale: 2, null: false
      t.decimal :tax_percentage, precision: 5, scale: 2, default: 0.0
      t.decimal :line_total, precision: 12, scale: 2, null: false

      t.timestamps
    end
  end
end
