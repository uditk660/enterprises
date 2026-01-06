class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.references :company, foreign_key: true
      t.references :user, foreign_key: true

      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.string :aadhaar_number
      t.string :pan_number
      t.string :designation
      t.string :department
      t.date :joining_date
      t.decimal :salary, precision: 12, scale: 2
      t.string :employee_status
      t.text :address
      t.text :notes

      t.timestamps
    end
  end
end
