class CreateLedgerEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :ledger_entries do |t|
      t.references :customer, foreign_key: true
      t.references :invoice, foreign_key: true
      t.date :entry_date
      t.string :entry_type
      t.string :description
      t.decimal :debit
      t.decimal :credit
      t.decimal :balance

      t.timestamps
    end
  end
end
