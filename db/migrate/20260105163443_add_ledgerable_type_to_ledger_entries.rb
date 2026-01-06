class AddLedgerableTypeToLedgerEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :ledger_entries, :ledgerable_type, :string
    add_column :ledger_entries, :employee_id, :integer
    add_column :ledger_entries, :employee_monthly_salary_id, :integer

    add_index :ledger_entries, :ledgerable_type
    add_index :ledger_entries, :employee_id
    add_index :ledger_entries, :employee_monthly_salary_id
  end
end
