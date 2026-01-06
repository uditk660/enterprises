class EmployeeMonthlySalary < ApplicationRecord
  belongs_to :employee
  belongs_to :employee_salary_structure

  attr_accessor :month_input

  validates :month, presence: true
  validates :month, uniqueness: { scope: :employee_id }


  enum payment_status: {
    pending: "pending",
    paid: "paid"
  }

  before_validation :normalize_month
  before_validation :calculate_net_salary

  private

  def normalize_month
    return unless month_input.present?

    parsed = Date.strptime(month_input, "%Y-%m")
    self.month = parsed.beginning_of_month
  end


  def calculate_net_salary
    self.basic_salary ||= employee_salary_structure.basic_salary
    self.allowances   ||= employee_salary_structure.allowances
    self.deductions   ||= 0

    self.net_salary = basic_salary.to_d + allowances.to_d + self.employee_salary_structure.hra || 0 - deductions.to_d
    self.payment_status ||= "pending"
  end
end
