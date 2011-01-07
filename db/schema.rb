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

ActiveRecord::Schema.define(:version => 20110107030817) do

  create_table "customers", :force => true do |t|
    t.string   "title"
    t.string   "given_name"
    t.string   "family_name"
    t.string   "organisation_name"
    t.string   "phone"
    t.string   "fax"
    t.boolean  "wants_receipt_by_email"
    t.string   "email"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "address_line_3"
    t.string   "city"
    t.string   "state"
    t.integer  "postalcode"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donations", :force => true do |t|
    t.string   "transaction_reference"
    t.string   "order_info"
    t.decimal  "amount",                :precision => 8, :scale => 2
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
