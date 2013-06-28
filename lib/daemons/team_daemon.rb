require File.expand_path('../../../config/environment', __FILE__)
require 'rubygems'

ActiveRecord::Base.connection.reconnect!

ENV['RAILS_ENV'] ||= 'development'

def parser_args
  ARGV.each do |arg|
    if arg.include?('=')
      key, val = arg.split('=', 2)
      ENV[key] = val
    end
  end
end

def create_log
  ruote_logger = ActiveSupport::BufferedLogger.new(File.join(Rails.root,
                                          'log', "daemons_#{ENV["team"]}.log"))
  Rails.logger = ruote_logger
  ActiveRecord::Base.logger = ruote_logger
  Rails.logger
end

def find_team
  Team.find(ENV['team'])
end

def tweet_steam(team)
  twitter_client = TweetStream::Client.new

  twitter_client.on_error do |message|
    logger.error message
  end

  twitter_client.track(team.name) do |tweet, client|
    if (team.current_match_start_time - 30.minutes) < DateTime.now &&
       (team.current_match_end_time   + 30.minutes) > DateTime.now
      Tweet.create_using_real_tweet(tweet, team)
    end
  end
end

parser_args

logger = create_log
team = find_team
team_name = team.name

logger.info "Starting: #{team_name}"
tweet_steam(team)
logger.info "Finish: #{team_name}"