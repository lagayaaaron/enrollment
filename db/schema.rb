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

ActiveRecord::Schema[7.0].define(version: 2023_05_03_013945) do
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

  create_table "administrators", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_administrators_on_user_id"
  end

  create_table "admissions", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "subject_schedule_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_admissions_on_student_id"
    t.index ["subject_schedule_id"], name: "index_admissions_on_subject_schedule_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instructors", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_instructors_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.string "email"
    t.date "birthdate"
    t.string "contact_number"
    t.text "address"
    t.string "profileable_type", null: false
    t.integer "profileable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profileable_id", "profileable_type"], name: "index_profiles_on_profileable_id_and_profileable_type", unique: true
    t.index ["profileable_type", "profileable_id"], name: "index_profiles_on_profileable"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "students", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_id"
    t.index ["course_id"], name: "index_students_on_course_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "subject_schedules", force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "instructor_id", null: false
    t.time "start_time"
    t.time "end_time"
    t.string "day_of_week"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instructor_id"], name: "index_subject_schedules_on_instructor_id"
    t.index ["subject_id"], name: "index_subject_schedules_on_subject_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "course_id"
    t.string "ancestry"
    t.string "code"
    t.index ["ancestry"], name: "index_subjects_on_ancestry"
    t.index ["course_id"], name: "index_subjects_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.integer "course_id"
    t.integer "year", default: 1
    t.integer "sem", default: 1
    t.index ["course_id"], name: "index_users_on_course_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admissions", "students"
  add_foreign_key "admissions", "subject_schedules"
  add_foreign_key "students", "courses"
  add_foreign_key "subject_schedules", "instructors"
  add_foreign_key "subject_schedules", "subjects"
  add_foreign_key "subjects", "courses"
  add_foreign_key "users", "courses"
end
