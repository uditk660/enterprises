class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :address
      t.string :gst_number
      t.string :phone

      t.timestamps
    end
  end
end
