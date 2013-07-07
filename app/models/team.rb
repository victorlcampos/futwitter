class Team < ActiveRecord::Base
  mount_uploader :badge, BadgeUploader

  has_many :home_matches, class_name: 'Match',
                          foreign_key: 'home_team_id', dependent: :destroy
  has_many :away_matches, class_name: 'Match',
                          foreign_key: 'away_team_id', dependent: :destroy
  has_many :news
  has_many :tweets

  attr_accessible :name
  after_create :schedule_twitter

  def match_tweets(match)
    tweets.match_tweets(match)
  end

  def matches
    my_id = self.id
    Match.where('home_team_id = ? OR away_team_id = ?', my_id, my_id)
  end

  def championships
    Championship.joins(:matches).merge(matches)
  end

  def championships_ids
    championships.pluck('championships.id')
  end

  def current_match
    matches.last
  end

  def current_match_start_time
    current_match.start_time
  end

  def current_match_open_time
    current_match.open_time
  end

  def current_match_close_time
    current_match.close_time
  end

  def name=(name)
    write_attribute(:name, name.downcase)
  end

  def name
    read_attribute(:name).humanize
  end

  private
  def schedule_twitter
    Resque.enqueue(TwitterStream, id)
  end
end