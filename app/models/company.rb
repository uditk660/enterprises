class Company < ApplicationRecord
  has_many :bills, dependent: :destroy

  has_many :invoices, dependent: :restrict_with_error
  has_one :bank_account, dependent: :destroy, inverse_of: :company
  belongs_to :user   # owner of the company
  has_many :employees, dependent: :destroy
  accepts_nested_attributes_for :bank_account, update_only: true
  validates :name, :address, :gst_number, presence: true
end
