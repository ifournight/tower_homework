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

ActiveRecord::Schema.define(version: 20170329081559) do

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

end
