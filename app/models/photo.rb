class Photo < ActiveRecord::Base
  belongs_to :team
  belongs_to :match

  attr_accessible :description, :team, :match, :url

  def self.create_by_tweet(tweet, team)
    url = tweet.media[0].media_url

    unless Photo.find_by_url(url)
      attributes = {
        description: tweet.text,
        team: team,
        match: team.current_match,
        url: url
      }
      Photo.create(attributes)
    end
  end
end
