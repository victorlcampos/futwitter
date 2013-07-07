class Tweet < ActiveRecord::Base
  scope :match_tweets, lambda { |match|
    where('created_at >= ? AND created_at <= ?',
                            match.open_time, match.close_time)
  }
  scope :geo, where(geo: true)

  belongs_to :team, counter_cache: true
  attr_accessible :geo, :text, :team, :minute, :latitude, :longitude
  delegate :name, to: :team, prefix: true

  def self.create_using_real_tweet(real_tweet, team)
    tweets_params = {
      text: real_tweet.text,
      team: team,
      minute: get_minute(team)
    }

    tweets_params.merge!(get_geo(real_tweet))

    Tweet.create!(tweets_params)
  end

  private
  def self.get_minute(team)
    (Time.zone.now - team.current_match_start_time) / 60
  end

  def self.get_geo(tweet)
    if geo = tweet.geo
      {
        geo: true,
        latitude:  geo.latitude,
        longitude: geo.longitude,
      }
    else
      {}
    end
  end
end
