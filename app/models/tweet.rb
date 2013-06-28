class Tweet < ActiveRecord::Base
  belongs_to :team, counter_cache: true
  attr_accessible :geo, :text, :team, :minute

  def self.create_using_real_tweet(real_tweet, team)
    tweets_params = {
      text: real_tweet.text,
      geo: real_tweet.geo,
      team: team,
      minute: get_minute(team)
    }
    Tweet.create!(tweets_params)
  end

  private
  def self.get_minute(team)
    (Time.zone.now - team.current_match_start_time) / 60
  end
end
