class CreateInvoiceItems < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_items do |t|
      t.references :invoice, foreign_key: true

      t.string :product_name, null: false
      t.date :dispatch_date
      t.string :challan_number
      t.string :destination

      t.decimal :weight, precision: 10, scale: 3, default: 0.0
      t.decimal :amount, precision: 12, scale: 2, default: 0.0

      t.timestamps
    end
  end
end