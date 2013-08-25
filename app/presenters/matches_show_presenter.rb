class MatchesShowPresenter
  attr_accessor :match
  def initialize(match)
    @match = match
  end

  def home_team_tweets_count
    match.home_team_tweets_count
  end

  def home_tweets_per_minute
    match.home_tweets_per_minute
  end

  def home_mood
    @home_mood ||= match.home_mood
  end

  def away_team_tweets_count
    match.away_team_tweets_count
  end

  def away_tweets_per_minute
    match.away_tweets_per_minute
  end

  def away_mood
    @away_mood ||= match.away_mood
  end

  def moves
    match.moves
  end

  def tweets_during_the_minutes
    result = {}

    get_tweets_group_by_minutes(:home).each do |key, value|
      result[key] = { home: value, away: 0 }
    end

    get_tweets_group_by_minutes(:away).each do |key, value|
      if result[key]
        result[key][:away] = value
      else
        result[key] = { home: 0, away: value }
      end
    end
    result.sort
  end

  def home_team_name
    match.home_team_name
  end

  def away_team_name
    match.away_team_name
  end

  private
  def get_tweets_group_by_minutes(team)
    match.send("#{team}_team_tweets").group(:minute).count(:minute)
  end
end