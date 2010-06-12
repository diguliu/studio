# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100612021518) do

  create_table "agendas", :force => true do |t|
    t.datetime "start",       :null => false
    t.integer  "duration",    :null => false
    t.integer  "room",        :null => false
    t.string   "status",      :null => false
    t.float    "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "band_id"
    t.integer  "service_id"
  end

  create_table "bands", :force => true do |t|
    t.string   "login",      :null => false
    t.string   "name",       :null => false
    t.string   "style"
    t.string   "homepage"
    t.string   "password",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bands_people", :id => false, :force => true do |t|
    t.integer "band_id"
    t.integer "person_id"
  end

  create_table "clients", :force => true do |t|
    t.string   "login",      :null => false
    t.string   "password",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
  end

  create_table "equips", :force => true do |t|
    t.string   "model"
    t.string   "description"
    t.string   "classification", :null => false
    t.float    "external_price", :null => false
    t.float    "internal_price", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at",   :null => false
    t.datetime "end_at",     :null => false
    t.integer  "agenda_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "external_rents", :force => true do |t|
    t.datetime "start"
    t.integer  "duration"
    t.string   "status"
    t.float    "price"
    t.integer  "client_id"
    t.integer  "equip_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "internal_rents", :force => true do |t|
    t.datetime "start"
    t.integer  "duration"
    t.integer  "agenda_id"
    t.integer  "equip_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "cpf",        :null => false
    t.string   "name",       :null => false
    t.text     "address"
    t.string   "email"
    t.string   "gender"
    t.string   "phone1"
    t.string   "phone2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.string   "name",        :null => false
    t.float    "price",       :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
