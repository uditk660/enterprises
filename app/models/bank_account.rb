class BankAccount < ApplicationRecord
  belongs_to :company, inverse_of: :bank_account
end
