class Customer < ApplicationRecord
	has_many :bills
	has_many :invoices, dependent: :restrict_with_error

  validates :name, presence: true
  validates :phone, presence: true
  validates :gst_number, presence: true
end
