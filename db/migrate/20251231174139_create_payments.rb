class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :customer, foreign_key: true
      t.references :invoice, foreign_key: true
      t.date :payment_date
      t.decimal :amount, precision: 12, scale: 2
      t.string :payment_mode
      t.string :reference

      t.timestamps
    end
  end
end
