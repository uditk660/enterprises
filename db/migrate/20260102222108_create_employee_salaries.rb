class CreateEmployeeSalaries < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_salaries do |t|
      t.references :employee, foreign_key: true
      t.integer :month
      t.integer :year
      t.decimal :basic,       precision: 12, scale: 2
      t.decimal :hra,         precision: 12, scale: 2
      t.decimal :allowances,  precision: 12, scale: 2
      t.decimal :deductions,  precision: 12, scale: 2
      t.decimal :net_salary,  precision: 12, scale: 2
      t.string :status, default: "UNPAID"

      t.timestamps
    end
  end
end
