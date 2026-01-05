class Payment < ApplicationRecord
  belongs_to :customer
  belongs_to :invoice, optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :payment_date, presence: true

  has_many :ledger_entries

  validate :invoice_must_be_open
  validate :amount_within_outstanding
  after_create :create_ledger_credit

  private

  def create_ledger_credit
    return unless invoice.present? # new change. Remove this if there any bug
    last_balance = customer.ledger_entries.order(:created_at).last&.balance || 0

    LedgerEntry.create!(
      customer: customer,
      invoice: invoice,
      entry_date: payment_date,
      entry_type: "credit",
      description: payment_description,
      debit: 0,
      credit: amount,
      balance: last_balance - amount
    )
  end

  def payment_description
    if invoice.present?
      "Payment received for Invoice #{invoice.invoice_number}"
    else
      "Advance payment received" # is this correct or just write here N/A
    end
  end

  def invoice_must_be_open
    if invoice.paid?
      errors.add(:invoice_id, "Invoice already fully paid")
    end
  end

  def amount_within_outstanding
    if amount.to_f > invoice.outstanding_amount
      errors.add(:amount, "Exceeds invoice outstanding amount")
    end
  end
end