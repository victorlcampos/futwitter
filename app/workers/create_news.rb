class CreateNews
  @queue = :news

  def self.perform(tweet, team_id)
    team = Team.find(team_id)
    News.create_by_tweet(tweet, team)
  end
end
