# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20260105163443) do

  create_table "bank_accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "company_id"
    t.string   "bank_name"
    t.string   "account_number"
    t.string   "ifsc_code"
    t.string   "branch"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["company_id"], name: "index_bank_accounts_on_company_id", using: :btree
  end

  create_table "bill_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "bill_id"
    t.integer  "product_id"
    t.integer  "quantity",                                default: 1,     null: false
    t.decimal  "rate",           precision: 10, scale: 2,                 null: false
    t.decimal  "tax_percentage", precision: 5,  scale: 2, default: "0.0"
    t.decimal  "line_total",     precision: 12, scale: 2,                 null: false
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.index ["bill_id"], name: "index_bill_items_on_bill_id", using: :btree
    t.index ["product_id"], name: "index_bill_items_on_product_id", using: :btree
  end

  create_table "bills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "bill_number",                                          null: false
    t.date     "date",                                                 null: false
    t.integer  "company_id"
    t.integer  "customer_id"
    t.decimal  "subtotal",    precision: 12, scale: 2, default: "0.0"
    t.decimal  "tax_amount",  precision: 12, scale: 2, default: "0.0"
    t.decimal  "round_off",   precision: 12, scale: 2, default: "0.0"
    t.decimal  "total",       precision: 12, scale: 2, default: "0.0"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["company_id"], name: "index_bills_on_company_id", using: :btree
    t.index ["customer_id"], name: "index_bills_on_customer_id", using: :btree
  end

  create_table "companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.text     "address",      limit: 65535
    t.string   "gst_number"
    t.string   "phone"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "udyam_number"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_companies_on_user_id", using: :btree
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "gst_number"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "address",    limit: 65535
  end

  create_table "employee_documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "employee_id"
    t.string   "title"
    t.string   "document_type"
    t.text     "notes",             limit: 65535
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.bigint   "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["employee_id"], name: "index_employee_documents_on_employee_id", using: :btree
  end

  create_table "employee_monthly_salaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "employee_id"
    t.integer  "employee_salary_structure_id"
    t.date     "month"
    t.decimal  "basic_salary",                               precision: 12, scale: 2
    t.decimal  "allowances",                                 precision: 12, scale: 2
    t.decimal  "deductions",                                 precision: 12, scale: 2
    t.decimal  "net_salary",                                 precision: 12, scale: 2
    t.string   "payment_status"
    t.date     "paid_on"
    t.text     "notes",                        limit: 65535
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
    t.index ["employee_id"], name: "index_employee_monthly_salaries_on_employee_id", using: :btree
    t.index ["employee_salary_structure_id"], name: "index_employee_monthly_salaries_on_employee_salary_structure_id", using: :btree
  end

  create_table "employee_salaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "employee_id"
    t.integer  "month"
    t.integer  "year"
    t.decimal  "basic",       precision: 12, scale: 2
    t.decimal  "hra",         precision: 12, scale: 2
    t.decimal  "allowances",  precision: 12, scale: 2
    t.decimal  "deductions",  precision: 12, scale: 2
    t.decimal  "net_salary",  precision: 12, scale: 2
    t.string   "status",                               default: "UNPAID"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.index ["employee_id"], name: "index_employee_salaries_on_employee_id", using: :btree
  end

  create_table "employee_salary_structures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "employee_id"
    t.decimal  "basic",          precision: 12, scale: 2
    t.decimal  "hra",            precision: 12, scale: 2
    t.decimal  "allowances",     precision: 12, scale: 2
    t.decimal  "deductions",     precision: 12, scale: 2
    t.date     "effective_from"
    t.boolean  "active",                                  default: true
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.index ["employee_id"], name: "index_employee_salary_structures_on_employee_id", using: :btree
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email"
    t.string   "aadhaar_number"
    t.string   "pan_number"
    t.string   "designation"
    t.string   "department"
    t.date     "joining_date"
    t.decimal  "salary",                        precision: 12, scale: 2
    t.string   "employee_status"
    t.text     "address",         limit: 65535
    t.text     "notes",           limit: 65535
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.index ["company_id"], name: "index_employees_on_company_id", using: :btree
    t.index ["user_id"], name: "index_employees_on_user_id", using: :btree
  end

  create_table "invoice_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "invoice_id"
    t.string   "product_name",                                            null: false
    t.date     "dispatch_date"
    t.string   "challan_number"
    t.string   "destination"
    t.decimal  "weight",         precision: 10, scale: 3, default: "0.0"
    t.decimal  "amount",         precision: 12, scale: 2, default: "0.0"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "weight_unit"
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id", using: :btree
  end

  create_table "invoices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "invoice_number",                                          null: false
    t.date     "invoice_date",                                            null: false
    t.integer  "company_id"
    t.integer  "customer_id"
    t.decimal  "subtotal",       precision: 12, scale: 2, default: "0.0"
    t.decimal  "gst_total",      precision: 12, scale: 2, default: "0.0"
    t.decimal  "round_off",      precision: 12, scale: 2, default: "0.0"
    t.decimal  "total_amount",   precision: 12, scale: 2, default: "0.0"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.index ["company_id"], name: "index_invoices_on_company_id", using: :btree
    t.index ["customer_id"], name: "index_invoices_on_customer_id", using: :btree
    t.index ["invoice_number"], name: "index_invoices_on_invoice_number", unique: true, using: :btree
  end

  create_table "ledger_entries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "customer_id"
    t.integer  "invoice_id"
    t.date     "entry_date"
    t.string   "entry_type"
    t.string   "description"
    t.decimal  "debit",                      precision: 12, scale: 2
    t.decimal  "credit",                     precision: 12, scale: 2
    t.decimal  "balance",                    precision: 12, scale: 2
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.string   "ledgerable_type"
    t.integer  "employee_id"
    t.integer  "employee_monthly_salary_id"
    t.index ["customer_id"], name: "index_ledger_entries_on_customer_id", using: :btree
    t.index ["employee_id"], name: "index_ledger_entries_on_employee_id", using: :btree
    t.index ["employee_monthly_salary_id"], name: "index_ledger_entries_on_employee_monthly_salary_id", using: :btree
    t.index ["invoice_id"], name: "index_ledger_entries_on_invoice_id", using: :btree
    t.index ["ledgerable_type"], name: "index_ledger_entries_on_ledgerable_type", using: :btree
  end

  create_table "payments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "customer_id"
    t.integer  "invoice_id"
    t.date     "payment_date"
    t.decimal  "amount",       precision: 12, scale: 2
    t.string   "payment_mode"
    t.string   "reference"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["customer_id"], name: "index_payments_on_customer_id", using: :btree
    t.index ["invoice_id"], name: "index_payments_on_invoice_id", using: :btree
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name",                                                    null: false
    t.decimal  "price",          precision: 10, scale: 2,                 null: false
    t.decimal  "tax_percentage", precision: 5,  scale: 2, default: "0.0"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.index ["name"], name: "index_products_on_name", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "bank_accounts", "companies"
  add_foreign_key "bill_items", "bills"
  add_foreign_key "bill_items", "products"
  add_foreign_key "bills", "companies"
  add_foreign_key "bills", "customers"
  add_foreign_key "companies", "users"
  add_foreign_key "employee_documents", "employees"
  add_foreign_key "employee_monthly_salaries", "employee_salary_structures"
  add_foreign_key "employee_monthly_salaries", "employees"
  add_foreign_key "employee_salaries", "employees"
  add_foreign_key "employee_salary_structures", "employees"
  add_foreign_key "employees", "companies"
  add_foreign_key "employees", "users"
  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoices", "companies"
  add_foreign_key "invoices", "customers"
  add_foreign_key "ledger_entries", "customers"
  add_foreign_key "ledger_entries", "invoices"
  add_foreign_key "payments", "customers"
  add_foreign_key "payments", "invoices"
end
