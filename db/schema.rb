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

ActiveRecord::Schema.define(version: 20150402174153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aliens", force: true do |t|
    t.string   "url"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "buckets", force: true do |t|
    t.string   "name"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buckets", ["organization_id"], name: "index_buckets_on_organization_id", using: :btree

  create_table "extractions", force: true do |t|
    t.integer  "resource_id",              null: false
    t.string   "title"
    t.text     "article"
    t.string   "author"
    t.text     "videos",      default: [],              array: true
    t.text     "feeds",       default: [],              array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "extractions", ["resource_id"], name: "index_extractions_on_resource_id", using: :btree

  create_table "hashtaggings", force: true do |t|
    t.integer  "resource_id"
    t.text     "text"
    t.text     "hashtags",    default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hashtaggings", ["resource_id"], name: "index_hashtaggings_on_resource_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bucket_id"
    t.boolean  "read",       default: false
    t.boolean  "approved",   default: false
  end

  add_index "resources", ["bucket_id"], name: "index_resources_on_bucket_id", using: :btree

  create_table "summarizations", force: true do |t|
    t.integer  "resource_id",              null: false
    t.text     "text"
    t.text     "sentences",   default: [],              array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "summarizations", ["resource_id"], name: "index_summarizations_on_resource_id", using: :btree

  create_table "tweets", force: true do |t|
    t.integer  "resource_id"
    t.string   "copy"
    t.string   "link"
    t.boolean  "approved",         default: false
    t.boolean  "sent",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_approved_at"
    t.datetime "last_sent_at"
  end

  add_index "tweets", ["resource_id"], name: "index_tweets_on_resource_id", using: :btree

end
