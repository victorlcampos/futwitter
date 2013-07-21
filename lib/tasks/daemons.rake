task 'daemons:stop' => :environment do
  run_rails = 'bundle exec ruby'
  stop = "stop"
  system "#{run_rails} #{TwitterStream::DAEMON_FILE} #{stop}"
end

task 'daemons:start' => :environment do
  run_rails = 'bundle exec ruby'
  start = "start"
  system "#{run_rails} #{TwitterStream::DAEMON_FILE} #{start}"
end