class InvoiceItem < ApplicationRecord
  belongs_to :invoice, inverse_of: :invoice_items

  WEIGHT_UNITS = ["kg", "g", "ton", "lb", "mg"]

  validates :weight_unit, inclusion: { in: WEIGHT_UNITS }
end