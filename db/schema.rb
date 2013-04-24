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

ActiveRecord::Schema.define(:version => 20130424040032) do

  create_table "faculties", :force => true do |t|
    t.string   "title"
    t.string   "abbr"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
  end

  add_index "groups", ["faculty_id"], :name => "index_groups_on_faculty_id"

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
