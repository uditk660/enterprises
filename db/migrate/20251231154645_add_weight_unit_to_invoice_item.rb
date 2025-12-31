class AddWeightUnitToInvoiceItem < ActiveRecord::Migration[5.0]
  def change
    add_column :invoice_items, :weight_unit, :string
  end
end
