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

ActiveRecord::Schema.define(version: 20141122212847) do

  create_table "activities", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "creator_id"
    t.boolean  "is_public"
    t.boolean  "is_live"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_activities", force: true do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.boolean  "is_displayed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",        default: "stopped"
  end

  add_index "user_activities", ["activity_id"], name: "index_user_activities_on_activity_id"
  add_index "user_activities", ["user_id"], name: "index_user_activities_on_user_id"

  create_table "user_activity_transitions", force: true do |t|
    t.string   "to_state"
    t.text     "metadata",         default: "{}"
    t.integer  "sort_key"
    t.integer  "user_activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_activity_transitions", ["sort_key", "user_activity_id"], name: "index_user_activity_transitions_on_two_things", unique: true
  add_index "user_activity_transitions", ["user_activity_id"], name: "index_user_activity_transitions_on_user_activity_id"

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
