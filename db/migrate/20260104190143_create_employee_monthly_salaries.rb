class CreateEmployeeMonthlySalaries < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_monthly_salaries do |t|
      t.references :employee, foreign_key: true
      t.references :employee_salary_structure, foreign_key: true

      t.date :month
      t.decimal :basic_salary, precision: 12, scale: 2
      t.decimal :allowances,   precision: 12, scale: 2
      t.decimal :deductions,   precision: 12, scale: 2
      t.decimal :net_salary,   precision: 12, scale: 2

      t.string :payment_status
      t.date :paid_on
      t.text :notes

      t.timestamps
    end
  end
end