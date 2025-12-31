class CreateBankAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_accounts do |t|
      t.references :company, foreign_key: true
      t.string :bank_name
      t.string :account_number
      t.string :ifsc_code
      t.string :branch

      t.timestamps
    end
  end
end
