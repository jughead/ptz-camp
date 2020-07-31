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

ActiveRecord::Schema.define(version: 20200731205548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "camp_field_sets", force: :cascade do |t|
    t.bigint "camp_id", null: false
    t.jsonb "fields"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_camp_field_sets_on_camp_id"
  end

  create_table "camps", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.string "slug", null: false
    t.text "telegram_intro", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date", default: "2017-01-30", null: false
    t.date "finish_date", default: "2017-02-09", null: false
    t.text "front_page"
    t.integer "registration"
    t.index ["created_at"], name: "index_camps_on_created_at"
    t.index ["registration"], name: "index_camps_on_registration"
    t.index ["slug"], name: "index_camps_on_slug"
    t.index ["updated_at"], name: "index_camps_on_updated_at"
  end

  create_table "day_schedules", id: :serial, force: :cascade do |t|
    t.integer "camp_id", null: false
    t.date "date", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_day_schedules_on_camp_id"
  end

  create_table "delegations", id: :serial, force: :cascade do |t|
    t.integer "camp_id"
    t.string "name"
    t.integer "supervisor_id"
    t.integer "max_teams", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_delegations_on_camp_id"
  end

  create_table "event_participations", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "participant_id"
    t.integer "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_participations_on_event_id"
    t.index ["participant_id"], name: "index_event_participations_on_participant_id"
  end

  create_table "event_restrictions", id: :serial, force: :cascade do |t|
    t.integer "event1_id"
    t.integer "event2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event1_id"], name: "index_event_restrictions_on_event1_id"
    t.index ["event2_id"], name: "index_event_restrictions_on_event2_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.integer "camp_id"
    t.string "name"
    t.text "description"
    t.datetime "start_at"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count_limit", default: 50
    t.index ["camp_id"], name: "index_events_on_camp_id"
    t.index ["position"], name: "index_events_on_position"
  end

  create_table "identities", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "text"
    t.jsonb "options"
    t.datetime "processed_at"
    t.integer "sent", default: 0, null: false
    t.integer "notifications_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "message_id"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "recipient_type", null: false
    t.integer "recipient_id", null: false
    t.index ["message_id"], name: "index_notifications_on_message_id"
    t.index ["recipient_type", "recipient_id", "message_id"], name: "index_recipient_message_on_notifications_uniq", unique: true
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.integer "camp_id"
    t.integer "state"
    t.text "title"
    t.text "content"
    t.string "slug"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_pages_on_camp_id"
  end

  create_table "participants", id: :serial, force: :cascade do |t|
    t.integer "camp_id"
    t.integer "delegation_id"
    t.integer "user_id"
    t.date "arrival"
    t.date "departure"
    t.jsonb "personal"
    t.string "passport_scan"
    t.integer "tshirt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.index ["camp_id"], name: "index_participants_on_camp_id"
    t.index ["delegation_id"], name: "index_participants_on_delegation_id"
    t.index ["team_id"], name: "index_participants_on_team_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "participants_roles", id: false, force: :cascade do |t|
    t.integer "participant_id"
    t.integer "role_id"
    t.index ["participant_id", "role_id"], name: "index_participants_roles_on_participant_id_and_role_id"
    t.index ["participant_id"], name: "index_participants_roles_on_participant_id"
    t.index ["role_id"], name: "index_participants_roles_on_role_id"
  end

  create_table "public_files", id: :serial, force: :cascade do |t|
    t.text "title"
    t.string "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "sessions", id: :serial, force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "teams", id: :serial, force: :cascade do |t|
    t.integer "camp_id"
    t.integer "delegation_id"
    t.string "name"
    t.boolean "with_laptop"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "flags"
    t.index ["camp_id"], name: "index_teams_on_camp_id"
    t.index ["delegation_id"], name: "index_teams_on_delegation_id"
  end

  create_table "telegram_groups", id: :serial, force: :cascade do |t|
    t.bigint "telegram_chat_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["telegram_chat_id"], name: "index_telegram_groups_on_telegram_chat_id"
  end

  create_table "telegram_users", id: :serial, force: :cascade do |t|
    t.bigint "telegram_chat_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "telegram_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "old_site", default: false, null: false
    t.text "name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  add_foreign_key "camp_field_sets", "camps"
  add_foreign_key "day_schedules", "camps"
  add_foreign_key "delegations", "camps"
  add_foreign_key "event_participations", "events"
  add_foreign_key "event_participations", "participants"
  add_foreign_key "event_restrictions", "events", column: "event1_id"
  add_foreign_key "event_restrictions", "events", column: "event2_id"
  add_foreign_key "events", "camps"
  add_foreign_key "identities", "users"
  add_foreign_key "pages", "camps"
  add_foreign_key "participants", "camps"
  add_foreign_key "participants", "delegations"
  add_foreign_key "participants", "users"
  add_foreign_key "teams", "camps"
  add_foreign_key "teams", "delegations"
end
