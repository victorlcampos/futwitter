require File.expand_path('../../../config/environment', __FILE__)
require 'rubygems'

ENV['RAILS_ENV'] ||= 'development'

def options
  {
    app_name: 'daemon_teams',
    dir: Rails.root.join('tmp', 'pids'),
    backtrac: true,
    monitor: false,
    log_output: true
  }
end

def create_log
  ruote_logger = ActiveSupport::BufferedLogger.new(File.join(Rails.root,
                                    'log', 'daemons.log'))
  Rails.logger = ruote_logger
  ActiveRecord::Base.logger = ruote_logger
  Rails.logger
end

def on_opened_time?(team)
  time_now = Time.zone.now
  (team.current_match_open_time)  < time_now &&
  (team.current_match_close_time) > time_now
end

def find_teams
  Team.all
end

def team_names(teams)
  teams.collect { |team| team.name }
end

def new_daemon
  TweetStream::Daemon.new('teams_daemon', options)
end

def create_tweet(tweet, team)
  real_tweet = Tweet.create_using_real_tweet(tweet, team)
  Resque.enqueue(Mood, real_tweet.id)
end

def create_news(tweet, team)
  if url = tweet.urls[0]
    hash_tweet = {
      retweet_count: tweet.retweet_count,
      created_at: tweet.created_at,
      url: url.expanded_url
    }
    Resque.enqueue(CreateNews, hash_tweet, team.id)
  end
end

def create_photo(tweet, team)
  Photo.create_by_tweet(tweet, team)
end

daemon = new_daemon
logger = nil
teams = find_teams

daemon.on_inited do
  ActiveRecord::Base.connection.reconnect!
  logger = create_log
  teams = find_teams
end

daemon.on_error do |message|
  logger.error message
end

daemon.track(*team_names(teams)) do |tweet|
  teams.each do |team|
    if tweet.text.downcase.match /#{team.name.downcase}/
      if on_opened_time?(team)
        create_news(tweet, team)
        create_tweet(tweet, team)

        if tweet.media.length > 0
          create_photo(tweet, team)
        end
      end

    end
  end
end