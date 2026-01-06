class CreateEmployeeDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_documents do |t|
      t.references :employee, foreign_key: true
      t.string :title
      t.string :document_type
      t.text :notes
      t.attachment :file

      t.timestamps
    end
  end
end
