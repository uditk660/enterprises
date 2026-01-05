class CreateEmployeeSalaryStructures < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_salary_structures do |t|
      t.references :employee, foreign_key: true

      t.decimal :basic,      precision: 12, scale: 2
      t.decimal :hra,        precision: 12, scale: 2
      t.decimal :allowances, precision: 12, scale: 2
      t.decimal :deductions, precision: 12, scale: 2

      t.date :effective_from
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
