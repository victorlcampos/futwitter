class Match < ActiveRecord::Base
  has_many :moves

  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :championship

  attr_accessible :home_team, :away_team, :home_team_score,
                  :away_team_score, :championship, :internet_url, :start_time

  delegate :name, to: :championship, prefix: true
  delegate :name, :badge_url, :tweets_count, to: :home_team, prefix: true
  delegate :name, :badge_url, :tweets_count, to: :away_team, prefix: true

  def home_tweets_per_minute
    team_tweets_per_minute(home_team)
  end

  def away_tweets_per_minute
    team_tweets_per_minute(away_team)
  end

  def end_time
    start_time + 2.hours
  end

  private
  def team_tweets_per_minute(team)
    (team.tweets_count / passed_minutes).round
  end

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
