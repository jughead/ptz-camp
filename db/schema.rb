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

ActiveRecord::Schema.define(version: 20170712054322) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "camps", force: :cascade do |t|
    t.string   "title",                                 null: false
    t.string   "slug",                                  null: false
    t.text     "telegram_intro",                        null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.date     "start_date",     default: '2017-01-30', null: false
    t.date     "finish_date",    default: '2017-02-09', null: false
    t.text     "front_page"
    t.index ["created_at"], name: "index_camps_on_created_at", using: :btree
    t.index ["slug"], name: "index_camps_on_slug", using: :btree
    t.index ["updated_at"], name: "index_camps_on_updated_at", using: :btree
  end

  create_table "day_schedules", force: :cascade do |t|
    t.integer  "camp_id",    null: false
    t.date     "date",       null: false
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_day_schedules_on_camp_id", using: :btree
  end

  create_table "delegations", force: :cascade do |t|
    t.integer  "camp_id"
    t.string   "name"
    t.integer  "supervisor_id"
    t.integer  "max_teams",     default: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["camp_id"], name: "index_delegations_on_camp_id", using: :btree
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "text"
    t.jsonb    "options"
    t.datetime "processed_at"
    t.integer  "sent",                default: 0, null: false
    t.integer  "notifications_count", default: 0, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "message_id"
    t.datetime "sent_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "recipient_type", null: false
    t.integer  "recipient_id",   null: false
    t.index ["message_id"], name: "index_notifications_on_message_id", using: :btree
    t.index ["recipient_type", "recipient_id", "message_id"], name: "index_recipient_message_on_notifications_uniq", unique: true, using: :btree
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "camp_id"
    t.integer  "delegation_id"
    t.integer  "user_id"
    t.date     "arrival"
    t.date     "departure"
    t.jsonb    "personal"
    t.string   "passport_scan"
    t.integer  "tshirt"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["camp_id"], name: "index_participants_on_camp_id", using: :btree
    t.index ["delegation_id"], name: "index_participants_on_delegation_id", using: :btree
    t.index ["user_id"], name: "index_participants_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_sessions_on_updated_at", using: :btree
  end

  create_table "telegram_groups", force: :cascade do |t|
    t.bigint   "telegram_chat_id", null: false
    t.string   "title"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["telegram_chat_id"], name: "index_telegram_groups_on_telegram_chat_id", using: :btree
  end

  create_table "telegram_users", force: :cascade do |t|
    t.bigint   "telegram_chat_id", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "telegram_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "old_site",               default: false, null: false
    t.text     "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "day_schedules", "camps"
  add_foreign_key "delegations", "camps"
  add_foreign_key "identities", "users"
  add_foreign_key "participants", "camps"
  add_foreign_key "participants", "delegations"
  add_foreign_key "participants", "users"
end
