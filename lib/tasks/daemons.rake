task 'daemons:stop' => :environment do
  Team.all.each do |team|
    run_rails = 'bundle exec ruby'
    stop = "stop team='#{team.id}'"
    system "#{run_rails} #{TwitterStream::DAEMON_FILE} #{stop}"
  end
end

task 'daemons:start' => :environment do
  Team.all.each do |team|
    run_rails = 'bundle exec ruby'
    start = "start team='#{team.id}'"
    system "#{run_rails} #{TwitterStream::DAEMON_FILE} #{start}"
  end
end