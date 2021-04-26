# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pg'
require './memo_class'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

not_found do
  'ファイルが存在しません'
end

get '/' do
  redirect '/memos'
end

def memo
  Memo.new
end

get '/memos' do
  @title = 'メモ一覧'
  @memos = memo.read_all
  erb :home
end

get '/memos/new' do
  @title = 'メモ作成'
  erb :new
end

post '/memos/new' do
  memo.create(params[:title], params[:content])
  redirect '/memos'
end

get '/memos/:id' do
  @memo = memo.read(params[:id])
  erb :show
end

get '/memos/:id/edit' do
  @memo = memo.read(params[:id])
  erb :edit
end

patch '/memos/:id' do
  memo.edit(params[:title], params[:content], params[:id])
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  memo.delete(params[:id])
  redirect '/memos'
end
