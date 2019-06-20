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

ActiveRecord::Schema.define(version: 20190620110649) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendships", force: :cascade do |t|
    t.string   "friendable_type"
    t.integer  "friendable_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blocker_id"
    t.integer  "status"
    t.index ["friendable_id", "friend_id"], name: "index_friendships_on_friendable_id_and_friend_id", unique: true, using: :btree
  end

  create_table "headings", force: :cascade do |t|
    t.string   "tag_name"
    t.string   "heading"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "member_id"
    t.index ["member_id"], name: "index_headings_on_member_id", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.string   "original_url"
    t.string   "shortened_url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.string   "password_digest"
  end

  add_foreign_key "headings", "members"
end
