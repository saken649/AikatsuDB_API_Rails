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

ActiveRecord::Schema.define(version: 2020_06_11_131530) do

  create_table "aitubes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "song_id", limit: 64, null: false
    t.string "youtube_id", limit: 16, null: false
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["song_id"], name: "fk_rails_68aa791092"
  end

  create_table "album_tracks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "album_id", limit: 64, null: false
    t.integer "tracks", null: false
    t.integer "disc_number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["album_id"], name: "fk_rails_4ab23890cf"
  end

  create_table "albums", id: :string, limit: 64, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "title", limit: 128, null: false
    t.string "sub_title", limit: 128
    t.datetime "sold_date", null: false
    t.string "image_path", limit: 128, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["sold_date"], name: "index_albums_on_sold_date"
  end

  create_table "character_singers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "character_id", limit: 16, null: false
    t.string "singer_id", limit: 32, null: false
    t.integer "is_current", limit: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["character_id"], name: "fk_rails_5d029fa157"
    t.index ["singer_id"], name: "fk_rails_e48310cadd"
  end

  create_table "characters", id: :string, limit: 16, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name_family", limit: 8, null: false
    t.string "name_first", limit: 8, null: false
    t.string "name_family_kana", limit: 16, null: false
    t.string "name_first_kana", limit: 16, null: false
    t.string "voice_actor_family", limit: 8, null: false
    t.string "voice_actor_first", limit: 8, null: false
    t.string "voice_actor_family_kana", limit: 16, null: false
    t.string "voice_actor_first_kana", limit: 16, null: false
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "creators", id: :string, limit: 32, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name_family", limit: 8
    t.string "name_first", limit: 8
    t.string "name_family_kana", limit: 16
    t.string "name_first_kana", limit: 16
    t.string "artist_name", limit: 32
    t.string "artist_name_kana", limit: 64
    t.string "production_id", limit: 32
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["production_id"], name: "fk_rails_5fad90afcf"
  end

  create_table "groups", id: :string, limit: 32, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "productions", id: :string, limit: 32, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 32, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "searches", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "keyword"
    t.string "related_table", limit: 32
    t.string "related_key"
    t.index ["keyword"], name: "keyword", type: :fulltext
  end

  create_table "series", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "title", limit: 64, null: false
    t.string "sub_title", limit: 64
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "singers", id: :string, limit: 32, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "parent_singer_id", limit: 32
    t.string "name_family", limit: 8
    t.string "name_first", limit: 8
    t.string "name_family_kana", limit: 16
    t.string "name_first_kana", limit: 16
    t.string "display_name", limit: 16
    t.string "group_id", limit: 32
    t.integer "has_children", limit: 1, null: false
    t.integer "is_current", limit: 1
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["group_id"], name: "fk_rails_49e5b52ea8"
    t.index ["parent_singer_id"], name: "fk_rails_79628e96ab"
  end

  create_table "song_albums", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "song_id", limit: 64, null: false
    t.string "album_id", limit: 64, null: false
    t.integer "track_number", null: false
    t.integer "disc_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["album_id"], name: "fk_rails_6a2aa8bcca"
    t.index ["song_id"], name: "fk_rails_54260e8fee"
  end

  create_table "song_characters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "song_id", limit: 64, null: false
    t.string "character_id", limit: 16, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["character_id"], name: "fk_rails_058efd859e"
    t.index ["song_id"], name: "fk_rails_cfa0fe787a"
  end

  create_table "song_creators", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "song_id", limit: 64, null: false
    t.string "creator_id", limit: 32, null: false
    t.string "creator_type", limit: 16, null: false
    t.integer "display_order"
    t.integer "production_displayable", limit: 1, null: false
    t.string "delimiter_to_next", limit: 4
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["creator_id"], name: "fk_rails_ceadc1da38"
    t.index ["song_id"], name: "fk_rails_313f91c823"
  end

  create_table "song_singers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "song_id", limit: 64, null: false
    t.string "singer_id", limit: 32, null: false
    t.integer "display_order"
    t.integer "group_displayable", limit: 1, null: false
    t.string "delimiter_to_next", limit: 4
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["singer_id"], name: "fk_rails_505d2df6e0"
    t.index ["song_id"], name: "fk_rails_7b7e9ea145"
  end

  create_table "songs", id: :string, limit: 64, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "parent_song_id", limit: 64
    t.string "title", limit: 128
    t.string "title_kana"
    t.string "sub_title", limit: 128
    t.integer "is_short", limit: 1, null: false
    t.string "song_type", limit: 8
    t.integer "series_id", null: false
    t.index ["parent_song_id"], name: "fk_rails_05036d730a"
    t.index ["series_id"], name: "fk_rails_80a89ae734"
  end

  add_foreign_key "aitubes", "songs"
  add_foreign_key "album_tracks", "albums"
  add_foreign_key "character_singers", "characters"
  add_foreign_key "character_singers", "singers"
  add_foreign_key "creators", "productions"
  add_foreign_key "singers", "groups"
  add_foreign_key "singers", "singers", column: "parent_singer_id"
  add_foreign_key "song_albums", "albums"
  add_foreign_key "song_albums", "songs"
  add_foreign_key "song_characters", "characters"
  add_foreign_key "song_characters", "songs"
  add_foreign_key "song_creators", "creators"
  add_foreign_key "song_creators", "songs"
  add_foreign_key "song_singers", "singers"
  add_foreign_key "song_singers", "songs"
  add_foreign_key "songs", "series"
  add_foreign_key "songs", "songs", column: "parent_song_id"
end
