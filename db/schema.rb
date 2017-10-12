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

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20171008173127) do
=======
ActiveRecord::Schema.define(version: 0) do
>>>>>>> master
=======
ActiveRecord::Schema.define(version: 20171009125354) do
>>>>>>> 726de587eda3fcafdb3d97aaae5466bee7cbf7ac

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

<<<<<<< HEAD
<<<<<<< HEAD
=======
ActiveRecord::Schema.define(version: 20171009125354) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

>>>>>>> 1eb9c228c96cb51639d4ccd6844afa8c2ebb3eea
  create_table "games", force: :cascade do |t|
    t.integer "white_player_id"
    t.integer "black_player_id"
    t.integer "winning_player_id"
    t.string "game_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

<<<<<<< HEAD
=======
>>>>>>> master
=======
=======
>>>>>>> 1eb9c228c96cb51639d4ccd6844afa8c2ebb3eea
  create_table "moves", force: :cascade do |t|
    t.integer "game_id"
    t.integer "piece_id"
    t.integer "rank"
    t.integer "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
<<<<<<< HEAD
>>>>>>> 726de587eda3fcafdb3d97aaae5466bee7cbf7ac
=======
>>>>>>> 1eb9c228c96cb51639d4ccd6844afa8c2ebb3eea
end
