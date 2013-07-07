require File.expand_path('../../../config/environment', __FILE__)
require 'rubygems'

ENV['RAILS_ENV'] ||= 'development'

def parser_args
  ARGV.each do |arg|
    if arg.include?('=')
      key, val = arg.split('=', 2)
      ENV[key] = val
    end
  end
end

def options(team_name)
  {
    app_name: team_name,
    dir: Rails.root.join('tmp', 'pids'),
    backtrac: true,
    monitor: true,
    log_output: true
  }
end

def create_log
  ruote_logger = ActiveSupport::BufferedLogger.new(File.join(Rails.root,
                                    "log", "daemons_#{ENV['team']}.log"))
  Rails.logger = ruote_logger
  ActiveRecord::Base.logger = ruote_logger
  Rails.logger
end

def on_opened_time?(team)
  time_now = Time.zone.now
  (team.current_match_open_time)  < time_now &&
  (team.current_match_close_time) > time_now
end

def find_team
  Team.find(ENV['team'])
end

def new_daemon
  TweetStream::Daemon.new("#{ENV['team']}_daemon", options(ENV['team']))
end

def create_tweet(tweet, team)
  Tweet.create_using_real_tweet(tweet, team) if on_opened_time?(team)
end

parser_args

daemon = new_daemon
logger = nil
team   = find_team

daemon.on_inited do
  ActiveRecord::Base.connection.reconnect!
  logger = create_log
  team = find_team
end

daemon.on_error do |message|
  logger.error message
end

daemon.track(team.name) do |tweet|
  create_tweet(tweet, team)
end