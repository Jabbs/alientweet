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

ActiveRecord::Schema.define(version: 20150413202228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "organization_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["trackable_id"], name: "index_activities_on_trackable_id", using: :btree

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

  create_table "comments", force: true do |t|
    t.integer  "contributor_id",   null: false
    t.string   "commentable_type", null: false
    t.integer  "commentable_id",   null: false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contributors", force: true do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contributors", ["organization_id"], name: "index_contributors_on_organization_id", using: :btree

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
    t.string   "name",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "tag_list",   default: ""
  end

  create_table "readings", force: true do |t|
    t.string   "readable_type"
    t.integer  "readable_id"
    t.integer  "contributor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "readings", ["contributor_id"], name: "index_readings_on_contributor_id", using: :btree
  add_index "readings", ["readable_type", "readable_id"], name: "index_readings_on_readable_type_and_readable_id", using: :btree

  create_table "resources", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bucket_id"
    t.boolean  "read",             default: false
    t.boolean  "approved",         default: false
    t.boolean  "archived",         default: false
    t.datetime "last_archived_at"
    t.string   "signature",        default: ""
    t.integer  "contributor_id"
    t.datetime "article_date"
    t.datetime "last_approved_at"
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
    t.boolean  "approved",             default: false
    t.boolean  "sent",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_approved_at"
    t.datetime "last_sent_at"
    t.integer  "contributor_id"
    t.boolean  "disproved",            default: false
    t.datetime "last_disproved_at"
    t.integer  "placement_id"
    t.boolean  "cleared",              default: false
    t.datetime "scheduled_to_send_at"
  end

  add_index "tweets", ["resource_id"], name: "index_tweets_on_resource_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
