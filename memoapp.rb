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

def write_memo_to_json(stored_memo_records)
  File.open(PATH_MEMO, 'w') { |file| JSON.dump(stored_memo_records, file) }
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

  stored_memo_records = load_memo_json
  id = stored_memo_records.empty? ? '1' : (stored_memo_records.keys.map(&:to_i).max + 1).to_s
  stored_memo_records[id] = { title:, content: }
  write_memo_to_json(stored_memo_records)

  redirect '/'
end

delete '/memo/:id' do
  stored_memo_records = load_memo_json
  stored_memo_records.delete(params[:id])
  write_memo_to_json(stored_memo_records)

  redirect '/'
end

get '/memo/:id/edit' do
  @memo = load_memo_json[params[:id]]
  erb :edit
end

patch '/memo/:id' do
  title = params[:title]
  content = params[:content]

  stored_memo_records = load_memo_json
  stored_memo_records[params[:id]] = { title:, content: }
  write_memo_to_json(stored_memo_records)

  redirect "/memo/#{params[:id]}"
end

not_found do
  '指定したページは存在しません'
end
