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

ActiveRecord::Schema.define(version: 20140711081757) do

  create_table "flavors", force: true do |t|
    t.string   "name"
    t.string   "flavor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ideas", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "name"
    t.string   "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ip_addresses", force: true do |t|
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nodes", force: true do |t|
    t.integer  "openstack_user_id"
    t.string   "name"
    t.string   "recipe"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "apps"
    t.string   "flavor"
    t.string   "image"
    t.string   "volume"
    t.string   "ipaddress"
    t.string   "status"
  end

  create_table "openstack_users", force: true do |t|
    t.string   "os_username"
    t.string   "os_password"
    t.string   "os_auth_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "signing_key_file"
    t.string   "chef_server_url"
    t.string   "client_name"
  end

  create_table "openstask_users", force: true do |t|
    t.string   "os_username"
    t.string   "os_password"
    t.string   "os_auth_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "volumes", force: true do |t|
    t.string   "name"
    t.string   "status"
    t.string   "volume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
