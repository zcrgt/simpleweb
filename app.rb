require "sinatra"
require "sinatra/reloader" if development?
require "sinatra/activerecord"
require "./user"

set :database_file, "./database.yml"

get '/' do
  @users = User.all
   erb :index
end

get '/health' do
  'OK'
end
