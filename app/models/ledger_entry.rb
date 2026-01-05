class LedgerEntry < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :invoice, optional: true
  belongs_to :payment, optional: true

  belongs_to :employee, optional: true
  belongs_to :employee_monthly_salary, optional: true

  enum entry_type: { debit: 0, credit: 1 }

  validates :entry_type, :entry_date, :description, presence: true
  validates :debit, :credit, numericality: { greater_than_or_equal_to: 0 }
  validate :single_side_entry
  validate :single_context_only

  scope :customer_ledger, -> { where(ledgerable_type: "customer") }
  scope :salary_ledger,   -> { where(ledgerable_type: "salary") }

  private

  def single_side_entry
    if debit.to_f > 0 && credit.to_f > 0
      errors.add(:base, "Ledger entry cannot have both debit and credit")
    end
  end

  def single_context_only
    case ledgerable_type
    when "customer"
      if customer_id.blank?
        errors.add(:customer, "must exist for customer ledger entry")
      end
      if employee_id.present? || employee_monthly_salary_id.present?
        errors.add(:base, "Customer ledger cannot reference employee data")
      end

    when "salary"
      if employee_id.blank? || employee_monthly_salary_id.blank?
        errors.add(:employee, "and salary month must exist for salary ledger entry")
      end
      if customer_id.present? || invoice_id.present?
        errors.add(:base, "Salary ledger cannot reference customer data")
      end

    else
      errors.add(:ledgerable_type, "is invalid")
    end
  end

  def debit?
    debit.to_f > 0
  end

  def credit?
    credit.to_f > 0
  end
end