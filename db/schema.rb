# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_21_103444) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "task_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "task_id", null: false
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_task_comments_on_task_id"
    t.index ["user_id"], name: "index_task_comments_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.date "due_date"
    t.integer "priority"
    t.integer "status"
    t.bigint "assignee_user_id", null: false
    t.bigint "assigner_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_user_id"], name: "index_tasks_on_assignee_user_id"
    t.index ["assigner_user_id"], name: "index_tasks_on_assigner_user_id"
  end

  create_table "tasks_task_categories", force: :cascade do |t|
    t.bigint "tasks_id", null: false
    t.bigint "task_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_category_id"], name: "index_tasks_task_categories_on_task_category_id"
    t.index ["tasks_id"], name: "index_tasks_task_categories_on_tasks_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "phone_number", null: false
    t.string "name", null: false
    t.integer "role", null: false
    t.string "password", null: false
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "task_comments", "tasks"
  add_foreign_key "task_comments", "users"
  add_foreign_key "tasks", "users", column: "assignee_user_id"
  add_foreign_key "tasks", "users", column: "assigner_user_id"
  add_foreign_key "tasks_task_categories", "task_categories"
  add_foreign_key "tasks_task_categories", "tasks", column: "tasks_id"
end
