require "bundler/capistrano"

load 'deploy/assets'

# ==============================================================
# SET's
# ==============================================================

default_run_options[:pty] = true 

set :user, "boscolotshirt"
set :domain, "boscolotshirt.com.br"
set :application, "tshirt_id"
# set :db_name, "boscolotshirt2"

set :scm, "git"
# set :scm_passphrase, "senha"
# set :scm_user, "usuario"
 
set :use_sudo, false  #railsplayground nao aceita sudo
set :deploy_via, :remote_cache
# set :git_shallow_clone, 1
set :remote, application
set :scm_verbose, true
set :copy_cache, true 
set :keep_releases, 5 # mantem ultimas versoes

task :set_folders do
  
  set :local_repository,  "ssh://#{user}@#{domain}/~/repo/#{deploy_folder}.git"
  set :repository,  "file:///home/#{user}/repo/#{deploy_folder}.git"

  set :deploy_to, "/home/#{user}/rails_projects/#{deploy_folder}"  #pasta para onde serao enviados os arquivos
  
end


# set :build_nokogiri, "--with-xslt-dir=/home/storage/c/9a/91/boscolotshirt/local --with-xml2-include=/home/storage/c/9a/91/boscolotshirt/local/include/libxml2 --with-xml2-lib=/home/storage/c/9a/91/boscolotshirt/local/lib"

# ==============================================================
# ROLE's
# ==============================================================

task :production do
  set :deploy_folder, "prod_" + application
  set :branch, "production" #branch que sera copiado
  
  set_folders
  server domain, :app, :web, :db, :primary => true
end

task :staging do
  set :deploy_folder, "dev_" + application
  set :branch, "master" #branch que sera copiado
  
  set_folders
  server domain, :app, :web, :db, :primary => true
end



# ==============================================================
# TASK's
# ==============================================================

before "deploy:update_code", "deploy:check_changes"

after "deploy:update_code", :roles => [:web, :db, :app] do
  deploy.copy_database_config
  run "chmod 755 #{release_path}/public -R"
end


# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  task :check_changes do

    if current_release && (current_revision == real_revision)
      Capistrano::CLI.ui.say("You don't have any changes to deploy")

      agree = Capistrano::CLI.ui.agree("Continue (Yes, [No]) ") do |q|
        q.default = 'n'
      end

      exit unless agree
    else
      # current_revision depends on current_path
      reset!(:current_path)
      reset!(:current_revision)
      reset!(:real_revision)
      reset!(:current_release)
    end
    
  end
  
  desc "copy database.yml into project"
  task :copy_database_config do
    # production_db_config = "/path_to_config/#{application}.yml"
    run "cp /home/#{user}/rails_projects/#{deploy_folder}/database.yml #{latest_release}/config/database.yml"
    puts "Replaced database.yml with live copy"
  end
  
  desc "uploads precompiled assets to production"
  task :deploy_assets, :except => { :no_release => true } do
    puts "Compiling assets locally"
    run_locally("rake assets:clean && rake assets:precompile")
    puts "Uploading assets to #{latest_release}/public/assets"
    top.upload("public/assets", "#{latest_release}/public/", :via => :scp, :recursive => true)
    run_locally("rake assets:clean")
  end

  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      
      # Always deploy assets on first release
      unless current_release
        deploy.deploy_assets
      else

        from = source.next_revision(current_revision)
        # puts "cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ lib/assets/ | wc -l"
        if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ lib/assets/ | wc -l").to_i > 0
          # run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
          deploy.deploy_assets
        else
          logger.info "Skipping asset pre-compilation because there were no asset changes"
        end
        
      end

    end
  end
end

