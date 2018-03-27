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

ActiveRecord::Schema.define(version: 20180227015403) do

  create_table "chat_rooms", force: :cascade do |t|
    t.string "title"
    t.integer "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_chat_rooms_on_league_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.integer "home_id", null: false
    t.integer "away_id", null: false
    t.string "result", limit: 5, default: "", null: false
    t.datetime "kickoff_at", null: false
    t.integer "stage", default: 0
    t.integer "round"
    t.integer "group"
    t.integer "stadium_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["away_id"], name: "index_games_on_away_id"
    t.index ["home_id"], name: "index_games_on_home_id"
    t.index ["stadium_id"], name: "index_games_on_stadium_id"
    t.index ["tournament_id"], name: "index_games_on_tournament_id"
  end

  create_table "guesses", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "game_id", null: false
    t.integer "league_id", null: false
    t.string "result", limit: 5, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_guesses_on_game_id"
    t.index ["league_id"], name: "index_guesses_on_league_id"
    t.index ["member_id"], name: "index_guesses_on_member_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name", limit: 5, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_leagues_on_name"
  end

  create_table "leagues_tournaments", id: false, force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.integer "league_id", null: false
    t.index ["league_id"], name: "index_leagues_tournaments_on_league_id"
    t.index ["tournament_id"], name: "index_leagues_tournaments_on_tournament_id"
  end

  create_table "members", force: :cascade do |t|
    t.integer "league_id", null: false
    t.integer "user_id", null: false
    t.integer "occupation", default: 0, null: false
    t.string "username", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_members_on_league_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.integer "user_id"
    t.integer "chat_room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "rankings", force: :cascade do |t|
    t.integer "league_id", null: false
    t.integer "tournament_id", null: false
    t.integer "member_id", null: false
    t.integer "point3", default: 0, null: false
    t.integer "point1", default: 0, null: false
    t.integer "point0", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_rankings_on_league_id"
    t.index ["member_id"], name: "index_rankings_on_member_id"
    t.index ["tournament_id"], name: "index_rankings_on_tournament_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "league_id", null: false
    t.datetime "accepted_at"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_requests_on_league_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "stadia", force: :cascade do |t|
    t.string "name", limit: 40, null: false
    t.string "city", limit: 20, null: false
    t.integer "capacity", limit: 5, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_stadia_on_name"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.string "code", limit: 3, null: false
    t.string "flag", limit: 20, null: false
    t.integer "selection", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "teams_tournaments", id: false, force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.integer "team_id", null: false
    t.index ["team_id"], name: "index_teams_tournaments_on_team_id"
    t.index ["tournament_id"], name: "index_teams_tournaments_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.string "location", limit: 20, null: false
    t.integer "year", limit: 4, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tournaments_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
