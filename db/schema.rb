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

ActiveRecord::Schema[8.0].define(version: 2025_08_30_230917) do
  create_table "bets", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "game_round_id", null: false
    t.decimal "amount"
    t.string "bet_color"
    t.decimal "payout"
    t.boolean "won"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_round_id"], name: "index_bets_on_game_round_id"
    t.index ["player_id"], name: "index_bets_on_player_id"
  end

  create_table "game_rounds", force: :cascade do |t|
    t.string "result_color"
    t.datetime "played_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "money"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bets", "game_rounds"
  add_foreign_key "bets", "players"
end
