# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_02_181537) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "actions", force: :cascade do |t|
    t.bigint "transaction_id", null: false
    t.decimal "deposit", precision: 30, default: "0", null: false
    t.string "action_type", null: false
    t.jsonb "data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data"], name: "index_actions_on_data", using: :gin
    t.index ["transaction_id"], name: "index_actions_on_transaction_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "external_id", null: false
    t.datetime "time", null: false
    t.integer "height", null: false
    t.string "hash", null: false
    t.string "block_hash", null: false
    t.string "sender", null: false
    t.string "receiver", null: false
    t.bigint "gas_burnt", null: false
    t.integer "actions_count", default: 0
    t.boolean "success", default: true, null: false
    t.datetime "api_created_at", null: false
    t.datetime "api_updated_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_transactions_on_external_id", unique: true
    t.index ["hash"], name: "index_transactions_on_hash", unique: true
  end

  add_foreign_key "actions", "transactions"
end
