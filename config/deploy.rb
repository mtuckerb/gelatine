set :application, "book_a_room"
set :repository,  "git@github.com:mtuckerb/gelatine.git"
set :scm, :git
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "ec2-54-234-254-197.compute-1.amazonaws.com"                          # Your HTTP server, Apache/etc
role :app, "ec2-54-234-254-197.compute-1.amazonaws.com"                        # This may be the same as your `Web` server
role :db,  "ec2-54-234-254-197.compute-1.amazonaws.com", :primary => true # This is where Rails migrations will run


# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

set :user,   "nobody"
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "awskey.pem")]
set :scm_username, "mtuckerb"
set :deploy_to, "/rails/gelatine"


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "touch #{File.join(current_path,'tmp','restart.txt')}" #{try_sudo} 
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