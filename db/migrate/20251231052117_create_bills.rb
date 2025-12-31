class CreateBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.string :bill_number, null: false
      t.date :date, null: false
      t.references :company, foreign_key: true
      t.references :customer, foreign_key: true
      t.decimal :subtotal,   precision: 12, scale: 2, default: 0.0
      t.decimal :tax_amount, precision: 12, scale: 2, default: 0.0
      t.decimal :round_off,  precision: 12, scale: 2, default: 0.0
      t.decimal :total,      precision: 12, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
