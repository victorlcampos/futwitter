require 'bundler/capistrano'
set :application, "futwitter"

set :user, 'root'
set :use_sudo, false
set :normalize_asset_timestamps, false

set :repository,  "git@github.com:victorlcampos/futwitter.git"

set :deploy_to, "/var/www/#{application}"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "futwitter.almadegordo.com"                          # Your HTTP server, Apache/etc
role :app, "futwitter.almadegordo.com"                          # This may be the same as your `Web` server
role :db,  "futwitter.almadegordo.com", primary: true # This is where Rails migrations will run
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