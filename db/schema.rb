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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.string   "num_order"
    t.string   "customer"
    t.string   "color"
    t.integer  "amount"
    t.integer  "loss"
    t.integer  "plates"
    t.float    "fabric"
    t.float    "foam"
    t.integer  "total"
    t.integer  "is_factured"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.integer  "input_output"
    t.decimal  "red_fabric"
    t.decimal  "white_fabric"
    t.decimal  "black_fabric"
    t.decimal  "foam"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
