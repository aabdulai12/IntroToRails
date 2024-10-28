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

ActiveRecord::Schema[7.1].define(version: 2024_10_27_174656) do
  create_table "animal_adoptions", force: :cascade do |t|
    t.string "animalid"
    t.string "intype"
    t.date "indate"
    t.string "petname"
    t.string "animaltype"
    t.string "petage"
    t.string "petsize"
    t.string "color"
    t.string "breed"
    t.string "sex"
    t.string "url"
    t.string "crossing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "breeds", force: :cascade do |t|
    t.string "name"
    t.string "group"
    t.string "section"
    t.string "country"
    t.string "url"
    t.string "image"
    t.string "pdf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "food_to_avoid"
    t.string "dog_type"
  end

  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.integer "breed_id", null: false
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country"
    t.index ["breed_id"], name: "index_dogs_on_breed_id"
    t.index ["owner_id"], name: "index_dogs_on_owner_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vet_visits", force: :cascade do |t|
    t.date "visit_date"
    t.text "description"
    t.integer "dog_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vet_clinic"
    t.index ["dog_id"], name: "index_vet_visits_on_dog_id"
  end

  add_foreign_key "dogs", "breeds"
  add_foreign_key "dogs", "owners"
  add_foreign_key "vet_visits", "dogs"
end
