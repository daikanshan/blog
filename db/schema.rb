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

ActiveRecord::Schema.define(version: 20151122085145) do

  create_table "admin_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.integer  "father_id",  limit: 4
    t.integer  "weight",     limit: 4
    t.integer  "level",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "admin_comments", force: :cascade do |t|
    t.integer  "from",       limit: 4
    t.integer  "to",         limit: 4
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.integer  "message_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "admin_messages", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.string   "abstract",   limit: 255
    t.string   "author",     limit: 255
    t.string   "tag",        limit: 255
    t.string   "category",   limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "admin_messages_categories", id: false, force: :cascade do |t|
    t.integer "message_id",  limit: 4
    t.integer "category_id", limit: 4
  end

  create_table "admin_messages_tags", id: false, force: :cascade do |t|
    t.integer "message_id", limit: 4
    t.integer "tag_id",     limit: 4
  end

  create_table "admin_tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.integer  "weight",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "realname",        limit: 255
    t.string   "password_digest", limit: 255
    t.string   "email",           limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "front_navs", force: :cascade do |t|
    t.string   "text",       limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "url",        limit: 255
    t.string   "icon",       limit: 255
    t.integer  "shown",      limit: 4
    t.string   "code",       limit: 255
    t.integer  "supnav_id",  limit: 4
    t.integer  "weight",     limit: 4
    t.integer  "level",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
