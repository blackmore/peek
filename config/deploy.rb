# set :ruby, "/usr/local/bin"
set :application, "peek"
set :repository,  "git@github.com:blackmore/peek.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
#set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:

set :scm, :git
set :runner, nil
server "10.1.1.201", :app, :web, :db, :primary => true, :user => 'administrator'

# set :user, 'administrator'  # Your hosting account's username
# set :domain, '10.1.1.201'  # Hosting servername where your account is located
# set :project, 'peek'  # Your application as its called in the repository
# set :application, 'dev01.titelbild.de'  # Your app's location (domain or subdomain)
# set :applicationdir, "/home/administrator/webapps/#{user}/#{application}"  # The location of your application on your hosting (my differ for each hosting provider)
# # version control config
# set :scm, 'git'
# set :repository,  "git@github.com:blackmore/peek.git" # Your git repository location
# set :deploy_via, :remote_cache
# set :git_enable_submodules, 1 # if you have vendored rails
# set :branch, 'master'
# set :git_shallow_clone, 1
# set :scm_verbose, true
# # roles (servers)
# role :web, domain
# role :app, domain
# role :db,  domain, :primary => true
# # deploy config
# set :deploy_to, applicationdir # deploy to directory set above
# set :deploy_via, :export
# # additional settings
# default_run_options[:pty] = true  # Forgo errors when deploying from windows
# set :chmod755, "app config db lib public vendor script script/* public/disp*"
# set :use_sudo, false

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end