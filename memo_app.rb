require 'sinatra'
require 'sinatra/reloader'
require 'erb'

#  ホーム
get '/' do
  erb :home
end

# 投稿
get '/new' do
  erb :new
end

# 詳細
get '/show' do
  erb :show
end

# 変更
get '/edit' do
  erb :edit
end
