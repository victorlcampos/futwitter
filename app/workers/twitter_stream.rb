class TwitterStream
  @queue = :twitter
  DAEMON_FILE = File.join(Rails.root, 'lib', 'daemons', 'team_daemon.rb')
  def self.perform(team_id)
    system "bundle exec ruby #{DAEMON_FILE} stop"
    system "bundle exec ruby #{DAEMON_FILE} start"
  end
end