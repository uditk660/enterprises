class LedgerEntry < ApplicationRecord
  belongs_to :customer
  belongs_to :invoice, optional: true
  belongs_to :payment, optional: true

  enum entry_type: { debit: 0, credit: 1 }

  validates :entry_type, :entry_date, :description, presence: true
  validates :debit, :credit, numericality: { greater_than_or_equal_to: 0 }
  validate :single_side_entry

  private

  def single_side_entry
    if debit.to_f > 0 && credit.to_f > 0
      errors.add(:base, "Ledger entry cannot have both debit and credit")
    end
  end

  def debit?
    debit.to_f > 0
  end

  def credit?
    credit.to_f > 0
  end
end