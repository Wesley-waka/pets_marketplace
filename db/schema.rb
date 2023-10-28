# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_27_064523) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "ad_reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "ad_id", null: false
    t.integer "rating"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_id"], name: "index_ad_reviews_on_ad_id"
    t.index ["user_id"], name: "index_ad_reviews_on_user_id"
  end

  create_table "ads", force: :cascade do |t|
    t.string "name"
    t.integer "gender", default: 0
    t.string "breed"
    t.string "pet_type", null: false
    t.float "price", null: false
    t.text "description"
    t.integer "age"
    t.string "country"
    t.string "city"
    t.string "zipcode"
    t.string "email"
    t.string "phone_number"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ad_type"
    t.integer "ad_price", default: 0
    t.integer "status", default: 0
    t.index ["user_id"], name: "index_ads_on_user_id"
  end

  create_table "favourite_ads", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "ad_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ad_id"], name: "index_favourite_ads_on_ad_id"
    t.index ["user_id"], name: "index_favourite_ads_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "category"
    t.string "price_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.text "bio"
    t.integer "account_type"
    t.string "language"
    t.string "location"
    t.string "facebook_url"
    t.string "twitter_url"
    t.string "linkedin_url"
    t.string "whatsapp_url"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_image"
    t.string "phone_number"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.boolean "password_token_valid", default: false
    t.boolean "is_active", default: false
    t.string "activation_token"
    t.datetime "activation_token_expires_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "user_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "ad_reviews", "ads"
  add_foreign_key "ad_reviews", "users"
  add_foreign_key "ads", "users"
  add_foreign_key "favourite_ads", "ads"
  add_foreign_key "favourite_ads", "users"
  add_foreign_key "profiles", "users"
end
