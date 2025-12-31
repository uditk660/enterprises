class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :customer
 
  has_many :ledger_entries, dependent: :restrict_with_error
  has_many :invoice_items, dependent: :destroy, inverse_of: :invoice
  accepts_nested_attributes_for :invoice_items, allow_destroy: true

  before_validation :set_invoice_number, on: :create
  after_create :create_ledger_debit


  # Class method to generate next invoice number without saving
  def self.set_invoice_number
    today = Date.today
    fy_start_year = today.month >= 4 ? today.year : today.year - 1
    fy_end_year   = fy_start_year + 1
    financial_year = "#{fy_start_year}-#{fy_end_year.to_s[-2..-1]}"

    last_invoice = Invoice.where("invoice_number LIKE ?", "SE#{fy_start_year}-#{fy_end_year.to_s[-2..-1]}/FL%")
                          .order(:id).last

    if last_invoice&.invoice_number.present?
      last_number = last_invoice.invoice_number.split("/FL").last.to_i
      new_number = last_number + 1
    else
      new_number = 100
    end

    "SE#{financial_year}/FL#{new_number}"
  end

    # ===== OUTSTANDING AMOUNT =====
    def outstanding_amount
      debit  = ledger_entries.sum(:debit)
      credit = ledger_entries.sum(:credit)
      debit - credit
    end

    def paid?
      outstanding_amount <= 0
    end

    # ===== ONLY OPEN INVOICES =====
    scope :open_invoices, -> {
      left_joins(:ledger_entries)
        .group("invoices.id")
        .having("COALESCE(SUM(ledger_entries.debit),0) > COALESCE(SUM(ledger_entries.credit),0)")
    }

  private

  # Instance method called before save
  def set_invoice_number
    self.invoice_number ||= Invoice.next_invoice_number
  end

  def create_ledger_debit
    last_balance = customer.ledger_entries.order(:id).last&.balance || 0

    LedgerEntry.create!(
      customer: customer,
      invoice: self,
      entry_date: invoice_date,
      entry_type: "debit",
      description: "Invoice #{invoice_number}",
      debit: total_amount,
      credit: 0,
      balance: last_balance + total_amount
    )
  end
end