require "bundler/capistrano"
require "rvm/capistrano"

set :rvm_ruby_string, :local              # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"       # more info: rvm help autolibs
set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user 
default_run_options[:pty] = true

before 'deploy:setup', 'rvm:install_rvm'  # install/update RVM
before 'deploy:setup', 'rvm:install_ruby'

set :default_environment, {
  'LANG' => 'en_US.UTF-8',
  'PATH' => '/usr/kerberos/sbin:/usr/sbin:/sbin:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin'
}
set :application, "gelatine"
set :repository,  "git@github.com:mtuckerb/gelatine.git"
set :scm, :git
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "69.25.136.108"                          # Your HTTP server, Apache/etc
role :app, "69.25.136.108"                        # This may be the same as your `Web` server
role :db,  "69.25.136.108", :primary => true # This is where Rails migrations will run


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"
set :stages, ["staging", "production"]
set :default_stage, "staging"

set :user,   "apache"
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_dsa")]
set :scm_username, "mtuckerb"
set :deploy_to, "/rails/gelatine"


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     #run "touch #{File.join(current_path,'tmp','restart.txt')}" #{try_sudo} 
   end
   
   namespace :assets do
     task :precompile, :roles => :web, :except => { :no_release => true } do
       from = source.next_revision(current_revision)
       if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
         run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
        else
          logger.info "Skipping asset pre-compilation because there were no asset changes"
        end
      end
   end
 end
namespace :dragonfly do
   desc "Symlink the Rack::Cache files"
   task :symlink, :roles => [:app] do
     run "mkdir -p #{shared_path}/public/system/dragonfly && ln -nfs #{shared_path}/public/system/dragonfly #{release_path}/public/system/dragonfly"
   end
end
after 'deploy:update_code', 'dragonfly:symlink'
load  'deploy/assets'
after "deploy:update_code", "deploy:restart"
