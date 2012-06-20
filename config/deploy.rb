require "bundler/capistrano"

# load 'deploy/assets'

# ==============================================================
# SET's
# ==============================================================

default_run_options[:pty] = true 

set :user, "boscolotshirt"
set :domain, "ftp.boscolotshirt.com.br"
set :application, "dev_tshirt_id"
# set :db_name, "boscolotshirt2"

set :local_repository,  "ssh://#{user}@#{domain}/~/repo/#{application}.git"
set :repository,  "file:///home/#{user}/repo/#{application}.git"
set :scm, "git"
# set :scm_passphrase, "senha"
# set :scm_user, "usuario"
 
set :use_sudo, false  #railsplayground nao aceita sudo
set :branch, "master" #branch que sera copiado
set :deploy_to, "/home/#{user}/rails_projects/#{application}"  #pasta para onde serao enviados os arquivos
# set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :remote, user
set :scm_verbose, true
set :copy_cache, true 
set :keep_releases, 5 # mantem 5 versoes

set :build_nokogiri, "--with-xslt-dir=/home/storage/c/9a/91/boscolotshirt/local --with-xml2-include=/home/storage/c/9a/91/boscolotshirt/local/include/libxml2 --with-xml2-lib=/home/storage/c/9a/91/boscolotshirt/local/lib"

# ==============================================================
# ROLE's
# ==============================================================

server domain, :app, :web, :db, :primary => true


# ==============================================================
# TASK's
# ==============================================================
 
after "deploy:update_code", :roles => [:web, :db, :app] do
  deploy.copy_database_config
  run "chmod 755 #{release_path}/public -R"
  deploy.deploy_assets
end


# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  desc "copy database.yml into project"
  task :copy_database_config do
    # production_db_config = "/path_to_config/#{application}.yml"
    run "cp /home/#{user}/rails_projects/#{application}/database.yml #{current_release}/config/database.yml"
    puts "replaced database.yml with live copy"
  end
  
  desc "uploads precompiled  assets to production"
  task :deploy_assets, :except => { :no_release => true } do
     run_locally("rake assets:clean && rake assets:precompile")
     # puts "uploading to #{release_path}/public/assets"
     top.upload("public/assets", "#{release_path}/public/assets", :via => :scp, :recursive => true)
     # top.upload("public/assets", "/home/boscolotshirt/rails_projects/dev_tshirt_id/releases/20120620212654/public/assets", :via => :scp, :recursive => true)
     run_locally("rake assets:clean")
  end
end

