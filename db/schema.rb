# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120508133117) do

  create_table "admins", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password"
    t.integer  "status"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consults", :force => true do |t|
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.datetime "date"
    t.boolean  "payment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doctors", :force => true do |t|
    t.integer  "department_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drugs", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoices", :force => true do |t|
    t.integer  "consult_id"
    t.integer  "product_id"
    t.boolean  "product_type"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", :force => true do |t|
    t.string   "tc"
    t.integer  "file_no"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "gender"
    t.integer  "phone"
    t.string   "email"
    t.string   "image_url"
    t.date     "birthday"
    t.string   "birthplace"
    t.boolean  "insurance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trial_histories", :force => true do |t|
    t.integer  "trial_request_id"
    t.integer  "request_admin_id"
    t.integer  "reply_admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trial_requests", :force => true do |t|
    t.integer  "consult_id"
    t.integer  "trial_type_id"
    t.boolean  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trial_results", :force => true do |t|
    t.integer  "trial_request_id"
    t.integer  "sequence"
    t.integer  "trial_id"
    t.integer  "min_range"
    t.integer  "max_range"
    t.integer  "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trial_types", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trials", :force => true do |t|
    t.integer  "trial_type_id"
    t.string   "name"
    t.integer  "min_range"
    t.integer  "max_range"
    t.string   "units"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
