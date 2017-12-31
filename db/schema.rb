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

ActiveRecord::Schema.define(version: 20171229051116) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "category_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "comment"
    t.string   "name"
    t.integer  "review_post_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "progresses", force: :cascade do |t|
    t.string   "name"
    t.integer  "progress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relevant_links", force: :cascade do |t|
    t.integer  "review_post_id"
    t.string   "title"
    t.string   "source"
    t.string   "link_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "relevant_links", ["review_post_id"], name: "index_relevant_links_on_review_post_id", using: :btree

  create_table "relevants", force: :cascade do |t|
    t.string   "Link"
    t.integer  "review_post_id"
    t.string   "title"
    t.string   "source"
    t.string   "link_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "relevants", ["review_post_id"], name: "index_relevants_on_review_post_id", using: :btree

  create_table "review_posts", force: :cascade do |t|
    t.integer  "user_admin_id"
    t.integer  "category_id"
    t.text     "contents"
    t.text     "title"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.text     "review"
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "reviews", ["category_id"], name: "index_reviews_on_category_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "task_boards", force: :cascade do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "task_boards", ["owner_type", "owner_id"], name: "index_task_boards_on_owner_type_and_owner_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.integer  "progress_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tasks", ["owner_type", "owner_id"], name: "index_tasks_on_owner_type_and_owner_id", using: :btree
  add_index "tasks", ["progress_id"], name: "index_tasks_on_progress_id", using: :btree

  create_table "user_admins", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "email"
    t.string   "password_token"
    t.string   "reset_token"
    t.string   "user_type"
  end

  create_table "useradmins", force: :cascade do |t|
    t.string   "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "widgets", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "relevant_links", "review_posts"
  add_foreign_key "relevants", "review_posts"
  add_foreign_key "reviews", "categories"
  add_foreign_key "reviews", "users"
  add_foreign_key "tasks", "progresses"
end
