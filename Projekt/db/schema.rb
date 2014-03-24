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

ActiveRecord::Schema.define(:version => 20130110073437) do

  create_table "age_ranges", :force => true do |t|
    t.integer  "min_age"
    t.integer  "max_age"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "athletes", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "last_name"
    t.string   "first_name"
    t.date     "birthday"
    t.integer  "gender_id"
    t.string   "street"
    t.integer  "house_number"
    t.integer  "location_id"
    t.string   "phone"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.boolean  "activated",            :default => false
    t.string   "type"
    t.integer  "organization_unit_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  add_index "athletes", ["gender_id"], :name => "index_athletes_on_gender_id"
  add_index "athletes", ["location_id"], :name => "index_athletes_on_location_id"
  add_index "athletes", ["organization_unit_id"], :name => "index_athletes_on_organization_unit_id"

  create_table "athletes_organization_units", :id => false, :force => true do |t|
    t.integer "athlete_id",           :null => false
    t.integer "organization_unit_id", :null => false
  end

  create_table "athletes_sports", :id => false, :force => true do |t|
    t.integer "athlete_id", :null => false
    t.integer "sport_id",   :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "discipline_ages", :force => true do |t|
    t.integer  "discipline_id"
    t.integer  "age_range_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "discipline_ages", ["age_range_id"], :name => "index_discipline_ages_on_age_range_id"
  add_index "discipline_ages", ["discipline_id"], :name => "index_discipline_ages_on_discipline_id"

  create_table "disciplines", :force => true do |t|
    t.string   "name"
    t.date     "year"
    t.integer  "gender_id"
    t.integer  "unit_id"
    t.integer  "category_id"
    t.integer  "sport_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "disciplines", ["category_id"], :name => "index_disciplines_on_category_id"
  add_index "disciplines", ["gender_id"], :name => "index_disciplines_on_gender_id"
  add_index "disciplines", ["sport_id"], :name => "index_disciplines_on_sport_id"
  add_index "disciplines", ["unit_id"], :name => "index_disciplines_on_unit_id"

  create_table "districts", :force => true do |t|
    t.string   "name"
    t.integer  "federal_state_id"
    t.integer  "district_chief_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "districts", ["district_chief_id"], :name => "index_districts_on_district_chief_id"
  add_index "districts", ["federal_state_id"], :name => "index_districts_on_federal_state_id"

  create_table "federal_states", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "genders", :force => true do |t|
    t.string   "sex"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "postal_code"
    t.string   "name"
    t.integer  "district_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "locations", ["district_id"], :name => "index_locations_on_district_id"

  create_table "medals", :force => true do |t|
    t.integer  "points"
    t.string   "sign"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "organization_units", :force => true do |t|
    t.string   "name"
    t.string   "street"
    t.integer  "house_number"
    t.string   "phone_number"
    t.string   "email"
    t.string   "url"
    t.integer  "location_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "organization_units", ["location_id"], :name => "index_organization_units_on_location_id"

  create_table "organization_units_sport_facilities", :id => false, :force => true do |t|
    t.integer "organization_unit_id", :null => false
    t.integer "sport_facility_id",    :null => false
  end

  create_table "performances", :force => true do |t|
    t.float    "value"
    t.date     "date"
    t.integer  "athlete_id"
    t.integer  "discipline_id"
    t.integer  "examiner_id"
    t.integer  "district_chief_id"
    t.integer  "sport_facility_id"
    t.boolean  "inspected",         :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "performances", ["athlete_id"], :name => "index_performances_on_athlete_id"
  add_index "performances", ["discipline_id"], :name => "index_performances_on_discipline_id"
  add_index "performances", ["district_chief_id"], :name => "index_performances_on_district_chief_id"
  add_index "performances", ["examiner_id"], :name => "index_performances_on_examiner_id"
  add_index "performances", ["sport_facility_id"], :name => "index_performances_on_sport_facility_id"

  create_table "required_performances", :force => true do |t|
    t.float    "value"
    t.integer  "discipline_age_id"
    t.integer  "medal_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "required_performances", ["discipline_age_id"], :name => "index_required_performances_on_discipline_age_id"
  add_index "required_performances", ["medal_id"], :name => "index_required_performances_on_medal_id"

  create_table "sport_facilities", :force => true do |t|
    t.string   "name"
    t.string   "street"
    t.integer  "house_number"
    t.integer  "location_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "sport_facilities", ["location_id"], :name => "index_sport_facilities_on_location_id"

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "test_appointments", :force => true do |t|
    t.date     "start_date"
    t.time     "time"
    t.text     "info_text"
    t.boolean  "cancelled"
    t.integer  "discipline_id"
    t.integer  "sport_facility_id"
    t.integer  "district_chief_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "test_appointments", ["discipline_id"], :name => "index_test_appointments_on_discipline_id"
  add_index "test_appointments", ["district_chief_id"], :name => "index_test_appointments_on_district_chief_id"
  add_index "test_appointments", ["sport_facility_id"], :name => "index_test_appointments_on_sport_facility_id"

  create_table "units", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
