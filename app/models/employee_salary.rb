class EmployeeSalary < ApplicationRecord
  belongs_to :employee

  validates :month, :year, presence: true
  validates :month, inclusion: 1..12

  before_validation :calculate_salary

  def calculate_salary
    self.net_salary = (basic || 0) + (hra || 0) + (allowances || 0) - (deductions || 0)
  end
end
