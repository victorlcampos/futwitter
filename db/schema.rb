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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130827031116) do

  create_table "championships", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "matches_count", :default => 0
  end

  create_table "matches", :force => true do |t|
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.integer  "home_team_score"
    t.integer  "away_team_score"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "championship_id"
    t.string   "internet_url"
    t.datetime "start_time"
  end

  add_index "matches", ["away_team_id"], :name => "index_matches_on_away_team_id"
  add_index "matches", ["championship_id"], :name => "index_matches_on_championship_id"
  add_index "matches", ["home_team_id", "away_team_id"], :name => "index_matches_on_home_team_id_and_away_team_id"
  add_index "matches", ["home_team_id"], :name => "index_matches_on_home_team_id"

  create_table "moves", :force => true do |t|
    t.integer  "match_id"
    t.integer  "minute"
    t.string   "team_name"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "half"
  end

  add_index "moves", ["match_id"], :name => "index_moves_on_match_id"

  create_table "news", :force => true do |t|
    t.integer  "team_id"
    t.string   "image"
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "shorted_url"
    t.integer  "retweets"
    t.datetime "time"
    t.string   "domain_name"
    t.string   "image_url"
  end

  add_index "news", ["team_id"], :name => "index_news_on_team_id"

  create_table "photos", :force => true do |t|
    t.integer  "match_id"
    t.integer  "team_id"
    t.string   "url"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "photos", ["match_id"], :name => "index_photos_on_match_id"
  add_index "photos", ["team_id"], :name => "index_photos_on_team_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "badge"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "tweets_count", :default => 0
  end

  add_index "teams", ["name"], :name => "index_teams_on_name"

  create_table "trusted_domains", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tweets", :force => true do |t|
    t.integer  "team_id"
    t.string   "text"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "minute"
    t.boolean  "geo",        :default => false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "mood",       :default => 0
  end

  add_index "tweets", ["team_id"], :name => "index_tweets_on_team_id"

end
