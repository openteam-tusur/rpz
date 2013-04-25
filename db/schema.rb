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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130425012636) do

  create_table "chairs", :force => true do |t|
    t.text     "title"
    t.string   "abbr"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "faculties", :force => true do |t|
    t.string   "title"
    t.string   "abbr"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "group_semesters", :force => true do |t|
    t.integer  "group_id"
    t.integer  "starts_on_week_id"
    t.integer  "breaks_on_week_id"
    t.integer  "ends_on_week_id"
    t.integer  "semester_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "group_semesters", ["breaks_on_week_id"], :name => "index_group_semesters_on_breaks_on_week_id"
  add_index "group_semesters", ["ends_on_week_id"], :name => "index_group_semesters_on_ends_on_week_id"
  add_index "group_semesters", ["group_id"], :name => "index_group_semesters_on_group_id"
  add_index "group_semesters", ["semester_id"], :name => "index_group_semesters_on_semester_id"
  add_index "group_semesters", ["starts_on_week_id"], :name => "index_group_semesters_on_starts_on_week_id"

  create_table "groups", :force => true do |t|
    t.integer  "faculty_id"
    t.integer  "year_id"
    t.string   "number"
    t.integer  "year_forming"
    t.integer  "course"
    t.integer  "budget_studens_count"
    t.integer  "payment_students_count"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "subspeciality_id"
    t.string   "speciality_code"
    t.text     "speciality_title"
    t.text     "subspeciality_title"
    t.integer  "chair_id"
    t.integer  "plan_year"
  end

  add_index "groups", ["faculty_id"], :name => "index_groups_on_faculty_id"

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "faculty_id"
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "permissions", ["user_id", "role", "faculty_id"], :name => "by_user_and_role_and_faculty"

  create_table "semesters", :force => true do |t|
    t.string   "title"
    t.integer  "year_id"
    t.date     "starts_on"
    t.date     "ends_on"
    t.date     "breaks_on"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "semesters", ["year_id"], :name => "index_semesters_on_year_id"

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.text     "name"
    t.text     "email"
    t.text     "nickname"
    t.text     "first_name"
    t.text     "last_name"
    t.text     "location"
    t.text     "description"
    t.text     "image"
    t.text     "phone"
    t.text     "urls"
    t.text     "raw_info"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "users", ["uid"], :name => "index_users_on_uid"

  create_table "weeks", :force => true do |t|
    t.integer  "number"
    t.integer  "year_id"
    t.integer  "semester_id"
    t.date     "starts_on"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "weeks", ["semester_id"], :name => "index_weeks_on_semester_id"
  add_index "weeks", ["year_id"], :name => "index_weeks_on_year_id"

  create_table "years", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
