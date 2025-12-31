class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.string :invoice_number, null: false
      t.date :invoice_date, null: false

      t.references :company, foreign_key: true
      t.references :customer, foreign_key: true

      t.decimal :subtotal,     precision: 12, scale: 2, default: 0.0
      t.decimal :gst_total,    precision: 12, scale: 2, default: 0.0
      t.decimal :round_off,    precision: 12, scale: 2, default: 0.0
      t.decimal :total_amount, precision: 12, scale: 2, default: 0.0

      t.timestamps
    end

    add_index :invoices, :invoice_number, unique: true
  end
end
