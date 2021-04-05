# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

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

get '/memos' do
  @title = 'メモ一覧'
  files = Dir.glob('memos/*').sort_by { |file| File.mtime(file) }
  @memos = files.map { |file| JSON.parse(File.read(file), symbolize_names: true) }
  erb :home
end

get '/memos/new' do
  @title = 'メモ作成'
  erb :new
end

post '/memos/new' do
  hash = { id: SecureRandom.uuid, title: params[:title], content: params[:content] }
  File.open("memos/#{hash[:id]}.json", 'w') { |file| file.puts JSON.generate(hash) }
  redirect '/memos'
end

def filename_match?
  filename = File.basename(params[:id])
end

get '/memos/:id' do
  @title = 'メモ詳細'
  @memo = JSON.parse(File.read("memos/#{filename_match?}.json"), symbolize_names: true)
  erb :show
end

get '/memos/:id/edit' do
  @title = 'メモ内容変更'
  @memo = JSON.parse(File.read("memos/#{filename_match?}.json"), symbolize_names: true)
  erb :edit
end

patch '/memos/:id' do
  File.open("memos/#{params[:id]}.json", 'w') do |file|
    hash = { id: params[:id], title: params[:title], content: params[:content] }
    JSON.dump(hash, file)
  end
  redirect "/memos/#{params[:id]}"
end

delete '/memos/:id' do
  File.delete("memos/#{filename_match?}.json")
  redirect '/memos'
end
