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

ActiveRecord::Schema.define(version: 20170427144052) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.integer  "session_id"
    t.string   "name"
    t.string   "label"
    t.text     "value"
    t.integer  "kind",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_assets_on_session_id", using: :btree
  end

  create_table "communicators", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "presenters", force: :cascade do |t|
    t.integer  "communicator_id"
    t.integer  "session_id"
    t.integer  "position"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["communicator_id", "session_id"], name: "index_presenters_on_communicator_id_and_session_id", using: :btree
    t.index ["communicator_id"], name: "index_presenters_on_communicator_id", using: :btree
    t.index ["session_id"], name: "index_presenters_on_session_id", using: :btree
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "permalink"
    t.integer  "timeslot_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.datetime "finished_at"
    t.index ["slug"], name: "index_sessions_on_slug", unique: true, using: :btree
    t.index ["timeslot_id"], name: "index_sessions_on_timeslot_id", using: :btree
  end

  create_table "support_requests", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "completed",  default: false
    t.text     "notes"
  end

  create_table "timeslots", force: :cascade do |t|
    t.string   "name"
    t.string   "permalink"
    t.datetime "start_time",        null: false
    t.datetime "end_time",          null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.datetime "player_start_time", null: false
    t.datetime "player_end_time",   null: false
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.string   "first_name"
    t.string   "last_name"
    t.string   "org_name"
    t.boolean  "admin_role",             default: false
    t.boolean  "user_role",              default: true
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "assets", "sessions"
  add_foreign_key "presenters", "communicators"
  add_foreign_key "presenters", "sessions"
  add_foreign_key "sessions", "timeslots"
end
