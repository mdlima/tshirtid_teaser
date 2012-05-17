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

ActiveRecord::Schema.define(:version => 20120515214403) do

  create_table "email_subscriptions", :force => true do |t|
    t.string   "name"
    t.string   "email",                             :null => false
    t.boolean  "opt_in",          :default => true
    t.string   "opt_in_campaign"
    t.string   "ip"
    t.datetime "last_opt_in"
    t.datetime "last_opt_out"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "email_subscriptions", ["email"], :name => "email_subscriptions_email_index", :unique => true

end
