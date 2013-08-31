require 'bundler/capistrano'
require 'capistrano-resque'

set :application, 'futwitter'

set :user, 'root'
set :use_sudo, false
set :normalize_asset_timestamps, false

set :repository,  'git@github.com:victorlcampos/futwitter.git'

set :deploy_to, "/var/www/#{application}"

set :workers, { '*' => 2, 'mood' => 2 }

role :resque_worker,    'www.futwitter.com.br'
role :resque_scheduler, 'www.futwitter.com.br'
role :web, 'www.futwitter.com.br'
role :app, 'www.futwitter.com.br'
role :db,  'www.futwitter.com.br', primary: true
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end


namespace :uploads do

  desc <<-EOD
    Creates the upload folders unless they exist
    and sets the proper upload permissions.
  EOD
  task :setup, :except => { :no_release => true } do
    dirs = uploads_dirs.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
  end

  desc <<-EOD
    [internal] Creates the symlink to uploads shared folder
    for the most recently deployed version.
  EOD
  task :symlink, :except => { :no_release => true } do
    run "rm -rf #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end

  desc <<-EOD
    [internal] Computes uploads directory paths
    and registers them in Capistrano environment.
  EOD
  task :register_dirs do
    set :uploads_dirs,    %w(uploads uploads/partners)
    set :shared_children, fetch(:shared_children) + fetch(:uploads_dirs)
  end

  after       'deploy:finalize_update', 'uploads:symlink'
  on :start,  'uploads:register_dirs'

end