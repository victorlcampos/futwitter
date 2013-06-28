class TwitterStream
  @queue = :twitter
  DAEMON_FILE = File.join(Rails.root, 'lib', 'daemons', 'team_daemon.rb')
  def self.perform(team_id)
    team = Team.find(team_id)

    options = {
      app_name: team.name,
      ARGV: ['start', '-f', '--', "team=#{team.id}"],
      dir: Rails.root.join('pids'),
      backtrac: true,
      monitor: true
    }

    Daemons.run(DAEMON_FILE, options)
  end
end