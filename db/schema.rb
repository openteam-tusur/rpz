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

ActiveRecord::Schema.define(:version => 20130507021823) do

  create_table "chairs", :force => true do |t|
    t.text     "title"
    t.string   "abbr"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "year_id"
  end

  add_index "chairs", ["year_id"], :name => "index_chairs_on_year_id"

  create_table "checks", :force => true do |t|
    t.integer  "education_id"
    t.string   "kind"
    t.string   "title"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "checks", ["education_id"], :name => "index_checks_on_education_id"

  create_table "courses", :force => true do |t|
    t.integer  "faculty_id"
    t.integer  "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "courses", ["faculty_id"], :name => "index_courses_on_faculty_id"

  create_table "disciplines", :force => true do |t|
    t.text     "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "educations", :force => true do |t|
    t.integer  "group_semester_id"
    t.integer  "discipline_id"
    t.integer  "chair_id"
    t.string   "cycle_code"
    t.text     "cycle_title"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "stream_id"
    t.boolean  "gpo_alternative",   :default => false
  end

  add_index "educations", ["chair_id"], :name => "index_educations_on_chair_id"
  add_index "educations", ["discipline_id"], :name => "index_educations_on_discipline_id"
  add_index "educations", ["group_semester_id"], :name => "index_educations_on_group_semester_id"
  add_index "educations", ["stream_id"], :name => "index_educations_on_stream_id"

  create_table "faculties", :force => true do |t|
    t.string   "title"
    t.string   "abbr"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "year_id"
  end

  add_index "faculties", ["year_id"], :name => "index_faculties_on_year_id"

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
    t.string   "number"
    t.integer  "year_forming"
    t.integer  "course"
    t.integer  "budget_students_count"
    t.integer  "payment_students_count"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "subspeciality_id"
    t.string   "speciality_code"
    t.text     "speciality_title"
    t.text     "subspeciality_title"
    t.integer  "chair_id"
    t.integer  "plan_year"
    t.boolean  "archived",               :default => false
    t.boolean  "verified",               :default => false
    t.integer  "course_id"
  end

  add_index "groups", ["course_id"], :name => "index_groups_on_course_id"

  create_table "loadings", :force => true do |t|
    t.integer  "week_id"
    t.integer  "training_id"
    t.integer  "value"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "loadings", ["training_id"], :name => "index_loadings_on_training_id"
  add_index "loadings", ["week_id"], :name => "index_loadings_on_week_id"

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "context_id"
    t.string   "context_type"
  end

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

  create_table "streams", :force => true do |t|
    t.integer  "course_id"
    t.string   "title"
    t.integer  "semester_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "streams", ["course_id"], :name => "index_streams_on_course_id"
  add_index "streams", ["semester_id"], :name => "index_streams_on_semester_id"

  create_table "trainings", :force => true do |t|
    t.integer  "education_id"
    t.string   "kind"
    t.string   "title"
    t.integer  "planned_loading"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "monitored",       :default => false
  end

  add_index "trainings", ["education_id"], :name => "index_trainings_on_education_id"

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
