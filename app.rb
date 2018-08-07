require "sinatra"
require "sinatra/reloader" if development?
require "sinatra/activerecord"
require "aws-sdk-s3"
require "./user"

set :database_file, "./database.yml"

get '/' do
  @users = User.all
  s3 = Aws::S3::Resource.new(region: 'ap-southeast-2')
  bucket = s3.bucket('rg-test-simple-web')
  @image_url = bucket.objects(prefix: 'assets/logo.jpg').first.presigned_url(:get, expires_in: 10)

  erb :index
end

get '/health' do
  'OK'
end
