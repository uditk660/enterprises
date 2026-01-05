class EmployeeSalaryStructure < ApplicationRecord
  belongs_to :employee
  has_many :employee_monthly_salaries, dependent: :restrict_with_error

  validates :effective_from, presence: true
  validates :basic, numericality: { greater_than_or_equal_to: 0 }

  scope :active, -> { where(active: true) }

  before_create :deactivate_old_structures

  def gross_salary
    (basic || 0) + (hra || 0) + (allowances || 0)
  end

  private

  def deactivate_old_structures
    employee.employee_salary_structures.update_all(active: false)
  end
end
