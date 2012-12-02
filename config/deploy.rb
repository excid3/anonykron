set :application, "anonykron"
set :repository,  "https://github.com/excid3/anonykron.git"
set :deploy_to,   "/home/anonykron/webapps/universe"

set :scm, :git

role :web, "anonykron.webfactional.com"                          # Your HTTP server, Apache/etc
role :app, "anonykron.webfactional.com"                          # This may be the same as your `Web` server
role :db,  "anonykron.webfactional.com", :primary => true # This is where Rails migrations will run

set :user, "anonykron"
set :use_sudo, false

set :default_environment, {
  "GEM_HOME" => "/home/anonykron/webapps/universe/gems",
  "PATH" => "/home/anonykron/webapps/universe/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/anonykron/bin",
  "RUBYLIB" => "/home/anonykron/webapps/universe/lib"

}
default_run_options[:pty] = true

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"
after "deploy:finalize_update", "deploy:symlink_database"

namespace :deploy do
  desc "Symlink database.yml"
  task :symlink_database, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Restart nginx"
  task :restart do
    run "#{deploy_to}/bin/restart"
  end
end
