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

ActiveRecord::Schema.define(version: 20251231052151) do

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
    t.text     "address",    limit: 65535
    t.string   "gst_number"
    t.string   "phone"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "gst_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "bill_items", "bills"
  add_foreign_key "bill_items", "products"
  add_foreign_key "bills", "companies"
  add_foreign_key "bills", "customers"
end
