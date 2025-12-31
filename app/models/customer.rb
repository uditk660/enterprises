class Customer < ApplicationRecord
	has_many :bills
	has_many :invoices, dependent: :restrict_with_error
  has_many :ledger_entries, dependent: :destroy
  has_many :payments, dependent: :destroy 

  validates :name, presence: true
  validates :phone, presence: true
  validates :gst_number, presence: true
end
