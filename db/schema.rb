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

ActiveRecord::Schema.define(version: 20180508081042) do

  create_table "avatars", force: :cascade do |t|
    t.integer "profile_id"
    t.string "image_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_avatars_on_profile_id"
  end

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.string "name"
    t.string "type"
    t.integer "university_id"
    t.string "telephone"
    t.string "fax"
    t.string "url"
    t.string "nickname"
    t.index ["university_id"], name: "index_locations_on_university_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.text "biography"
    t.integer "karma", default: 0
    t.string "country_code"
    t.integer "user_id"
    t.integer "faculty_id"
    t.integer "avatar_id"
    t.index ["avatar_id"], name: "index_profiles_on_avatar_id"
    t.index ["faculty_id"], name: "index_profiles_on_faculty_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "password_digest", default: "", null: false
    t.boolean "activated", default: false, null: false
    t.string "code", default: "", null: false
    t.string "username", default: "", null: false
    t.string "role", default: "student", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
