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

ActiveRecord::Schema.define(version: 20150913150921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",         default: "no_viewed"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name_en"
    t.text     "description"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_type"
    t.integer  "parent_id"
    t.string   "name_es"
  end

  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id", using: :btree

  create_table "categories_promos", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "promo_id"
  end

  add_index "categories_promos", ["category_id", "promo_id"], name: "index_categories_promos_on_category_id_and_promo_id", using: :btree

  create_table "follows", force: :cascade do |t|
    t.string   "follower_type"
    t.integer  "follower_id"
    t.string   "followable_type"
    t.integer  "followable_id"
    t.datetime "created_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "likes", force: :cascade do |t|
    t.string   "liker_type"
    t.integer  "liker_id"
    t.string   "likeable_type"
    t.integer  "likeable_id"
    t.datetime "created_at"
  end

  add_index "likes", ["likeable_id", "likeable_type"], name: "fk_likeables", using: :btree
  add_index "likes", ["liker_id", "liker_type"], name: "fk_likes", using: :btree

  create_table "mentions", force: :cascade do |t|
    t.string   "mentioner_type"
    t.integer  "mentioner_id"
    t.string   "mentionable_type"
    t.integer  "mentionable_id"
    t.datetime "created_at"
  end

  add_index "mentions", ["mentionable_id", "mentionable_type"], name: "fk_mentionables", using: :btree
  add_index "mentions", ["mentioner_id", "mentioner_type"], name: "fk_mentions", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "transaction_id"
    t.datetime "expiration_date"
    t.float    "amount"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency"
    t.datetime "transaction_create_time"
    t.datetime "transaction_update_time"
    t.string   "payment_method"
    t.string   "shipping_address"
    t.string   "transaction_status"
  end

  add_index "payments", ["user_id"], name: "index_payments_on_user_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "zipcode"
    t.string   "email"
    t.text     "rewards_terms"
    t.string   "country"
    t.string   "city"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "places", ["user_id"], name: "index_places_on_user_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "name_es"
    t.string   "name_en"
    t.float    "price"
    t.text     "description_es"
    t.text     "description_en"
    t.string   "paypal_description_es"
    t.string   "paypal_description_en"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "promos", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "place_id"
    t.boolean  "published"
    t.datetime "published_at"
    t.integer  "role_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.text     "extra_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "banner_file_name"
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.datetime "banner_updated_at"
    t.datetime "unpublished_at"
    t.integer  "category_id"
    t.integer  "star_number",         default: 1
    t.integer  "subcategory1_id"
    t.integer  "subcategory2_id"
  end

  add_index "promos", ["category_id"], name: "index_promos_on_category_id", using: :btree
  add_index "promos", ["place_id"], name: "index_promos_on_place_id", using: :btree
  add_index "promos", ["role_id"], name: "index_promos_on_role_id", using: :btree

  create_table "redeem_taken_promos", force: :cascade do |t|
    t.integer  "taken_promo_id"
    t.integer  "redeem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "redeem_taken_promos", ["redeem_id"], name: "index_redeem_taken_promos_on_redeem_id", using: :btree
  add_index "redeem_taken_promos", ["taken_promo_id"], name: "index_redeem_taken_promos_on_taken_promo_id", using: :btree

  create_table "redeems", force: :cascade do |t|
    t.integer  "approved_by"
    t.integer  "user_id"
    t.integer  "place_id"
    t.text     "description"
    t.datetime "approved_at"
    t.datetime "rejected_at"
    t.integer  "rejected_by"
    t.text     "rejected_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_stars"
  end

  add_index "redeems", ["place_id"], name: "index_redeems_on_place_id", using: :btree
  add_index "redeems", ["user_id"], name: "index_redeems_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.string   "paypal_payer_id"
    t.string   "paypal_profile_id"
    t.integer  "plan_id"
    t.integer  "user_id"
    t.datetime "paid_until"
    t.boolean  "canceled",          default: false
    t.boolean  "free",              default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.datetime "deleted_at"
  end

  add_index "subscriptions", ["deleted_at"], name: "index_subscriptions_on_deleted_at", using: :btree
  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "taken_promos", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "promo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "promo_code"
    t.datetime "approved_at"
    t.integer  "approved_by"
    t.datetime "rejected_at"
    t.integer  "rejected_by"
    t.text     "rejected_reason"
  end

  add_index "taken_promos", ["promo_id"], name: "index_taken_promos_on_promo_id", using: :btree
  add_index "taken_promos", ["user_id"], name: "index_taken_promos_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "zipcode"
    t.string   "name"
    t.string   "last_name"
    t.string   "business_name"
    t.string   "address"
    t.string   "city"
    t.string   "manager"
    t.string   "phone"
    t.string   "authentication_token"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "search_code"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "users"
end
