class AddFieldsToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :udyam_number, :string
  end
end
