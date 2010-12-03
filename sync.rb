require 'rubygems'
require 'sinatra'
require 'json/pure'
require 'yaml'

CONFIG = YAML::load_file("config.yml") unless defined? CONFIG

get '/' do
    'Nothing to see here'
end

post '/notify' do
   payload = JSON.parse(params[:payload])
   repo_dir = CONFIG["repo_dir"]
   this_repo = repo_dir + "/" +  payload["repository"]["name"]
   ref = payload["ref"].split("/").last
   if ref == "master"
     cmd = "pushd #{this_repo}; git fetch origin; git checkout master; git pull origin; popd"
   else
     cmd = "pushd #{this_repo}; git fetch origin; git checkout master; git branch -f #{ref} origin/#{ref}; popd"
   end
   system cmd
end
