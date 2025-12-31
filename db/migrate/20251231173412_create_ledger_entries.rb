class CreateLedgerEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :ledger_entries do |t|
      t.references :customer, foreign_key: true
      t.references :invoice, foreign_key: true
      t.date :entry_date
      t.string :entry_type
      t.string :description
      t.decimal :debit,   precision: 12, scale: 2
      t.decimal :credit, precision: 12, scale: 2
      t.decimal :balance, precision: 12, scale: 2

      t.timestamps
    end
  end
end
