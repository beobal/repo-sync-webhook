require 'rubygems'
require 'sinatra'
require 'json/pure'
require 'git'
require 'yaml'
require 'logger'

CONFIG = YAML::load_file("config.yml") unless defined? CONFIG

get '/' do
    'Nothing to see here'
end

post '/notify' do
   payload = JSON.parse(params[:payload])
   repo_dir = CONFIG["repo_dir"]
   this_repo = repo_dir + "/" +  payload["repository"]["name"]
   repo = Git.open(this_repo, :log => Logger.new(STDOUT))
   out = repo.fetch
   puts out
end
