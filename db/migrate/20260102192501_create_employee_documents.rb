class CreateEmployeeDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :employee_documents do |t|
      t.references :employee, foreign_key: true
      t.string :title
      t.string :document_type
      t.text :notes

      # Paperclip-safe columns (NO t.attachment)
      t.string   :file_file_name
      t.string   :file_content_type
      t.bigint   :file_file_size
      t.datetime :file_updated_at

      t.timestamps
    end
  end
end
