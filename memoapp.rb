# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'cgi/escape'
set :environment, :production

PATH_MEMO = './memo.json'

def load_memo_json
  File.open(PATH_MEMO) { |file| JSON.parse(file.read) }
end

def write_memo_to_json(memo_deta)
  File.open(PATH_MEMO, 'w') { |file| JSON.dump(memo_deta, file) }
end

get '/' do
  @memo_list = load_memo_json
  erb :top
end

get '/new' do
  erb :new
end

get '/memo/:id' do
  @memo = load_memo_json[params[:id]]
  erb :show
end

post '/memo' do
  title = params[:title]
  content = params[:content]

  memo_deta = load_memo_json
  id = memo_deta.empty? ? '1' : (memo_deta.keys.map(&:to_i).max + 1).to_s
  memo_deta[id] = { 'title' => title, 'content' => content }
  write_memo_to_json(memo_deta)

  redirect '/'
end

delete '/memo/:id' do
  memo_deta = load_memo_json
  memo_deta.delete(params[:id])
  write_memo_to_json(memo_deta)

  redirect '/'
end

get '/memo/:id/edit' do
  @memo = load_memo_json[params[:id]]
  erb :edit
end

patch '/memo/:id' do
  title = params[:title]
  content = params[:content]

  memo_deta = load_memo_json
  memo_deta[params[:id]] = { 'title' => title, 'content' => content }
  write_memo_to_json(memo_deta)

  redirect "/memo/#{params[:id]}"
end

not_found do
  '指定したページは存在しません'
end
