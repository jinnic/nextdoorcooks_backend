# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_13_184606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "experiances", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "durationMin"
    t.integer "size"
    t.datetime "dates", array: true
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dates"], name: "index_experiances_on_dates", using: :gin
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "image"
    t.string "video"
    t.string "caption"
    t.bigint "user_id"
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["imageable_type", "imageable_id"], name: "index_items_on_imageable_type_and_imageable_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "likeable_id"
    t.string "likeable_type"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "stars"
    t.string "comment"
    t.integer "rateable_id"
    t.string "rateable_type"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rateable_type", "rateable_id"], name: "index_ratings_on_rateable_type_and_rateable_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.json "duration"
    t.json "ingredients"
    t.json "instructions"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "location"
    t.string "password_digest"
    t.string "bio"
    t.string "avatar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
