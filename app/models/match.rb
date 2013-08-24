class Match < ActiveRecord::Base
  default_scope order('id DESC')

  has_many :moves
  has_many :photos

  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :championship, counter_cache: true

  attr_accessible :home_team, :away_team, :home_team_score,
                  :away_team_score, :championship, :internet_url, :start_time

  delegate :name, to: :championship, prefix: true
  delegate :name, :badge_url, to: :home_team, prefix: true
  delegate :name, :badge_url, to: :away_team, prefix: true

  def home_team_tweets
    home_team.match_tweets(self)
  end

  def home_team_tweets_count
    home_team_tweets.count
  end

  def home_tweets_per_minute
    (home_team_tweets_count / passed_minutes).round
  end

  def geo_home_team_tweets
    home_team_tweets.geo
  end

  def away_team_tweets
    away_team.match_tweets(self)
  end

  def away_team_tweets_count
    away_team_tweets.count
  end

  def away_tweets_per_minute
    (away_team_tweets_count / passed_minutes).round
  end

  def geo_away_team_tweets
    away_team_tweets.geo
  end

  def end_time
    start_time + 2.hours
  end

  def open_time
    start_time - 30.minutes
  end

  def close_time
    end_time + 30.minutes
  end

  private
  def passed_minutes
    (end_time_count_tweet - start_time_count_tweet) / 60
  end

  def end_time_count_tweet
    [Time.zone.now, end_time + 30.minute].min
  end

  def start_time_count_tweet
    start_time - 30.minutes
  end
end
