require 'bundler/capistrano'
require 'whenever/capistrano'

set :application, "mom"

set :repository, "git://github.com/mission-of-mercy/minnesota.git"
set :deploy_via, :remote_cache

set :scm, :git
set :user, "deploy"

set :deploy_to, "/home/deploy/#{application}"
set :use_sudo, false

server "missionofmercy.local", :app, :web, :db, :primary => true

task :local do
  # TODO Change this path to a local install
  set :repository, %(/Users/byron/code/personal/ct_mission_of_mercy)
  set :deploy_via, :copy
  set :copy_exclude, [".git"]
end

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after 'deploy:update_code' do
  { "database.yml" => "config/database.yml",
    "mom.yml"      => "config/mom.yml"}.
   each do |from, to|
     run "ln -nfs #{shared_path}/#{from} #{release_path}/#{to}"
   end
end

after "deploy", "deploy:migrate"
after "deploy", "deploy:cleanup"

load 'deploy/assets'