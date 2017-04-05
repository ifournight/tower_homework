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

ActiveRecord::Schema.define(version: 20170405084226) do

  create_table "accesses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.string   "type",         null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["subject_id", "subject_type"], name: "index_accesses_on_subject_id_and_subject_type"
    t.index ["type"], name: "index_accesses_on_type"
    t.index ["user_id", "subject_id", "subject_type", "type"], name: "has access index", unique: true
    t.index ["user_id"], name: "index_accesses_on_user_id"
  end

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.string   "action",       null: false
    t.string   "subject_type", null: false
    t.integer  "subject_id",   null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["subject_id"], name: "index_activities_on_subject_id"
    t.index ["subject_type"], name: "index_activities_on_subject_type"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "creator_id"
    t.index ["creator_id"], name: "index_projects_on_creator_id"
    t.index ["name"], name: "index_projects_on_name"
    t.index ["team_id"], name: "index_projects_on_team_id"
  end

  create_table "team_memberships", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "member_id"
    t.string   "member_authority"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["member_id"], name: "index_team_memberships_on_member_id"
    t.index ["team_id", "member_id"], name: "index_team_memberships_on_team_id_and_member_id"
    t.index ["team_id"], name: "index_team_memberships_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name"
    t.index ["owner_id"], name: "index_teams_on_owner_id"
  end

  create_table "todos", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "title",                       null: false
    t.text     "description"
    t.boolean  "completed",   default: false
    t.boolean  "deleted",     default: false
    t.datetime "deadline"
    t.datetime "edited_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "project_id"
    t.index ["creator_id"], name: "index_todos_on_creator_id"
    t.index ["project_id"], name: "index_todos_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name"
  end

end
