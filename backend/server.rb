require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)

require 'json'
require_relative './ext/hash'
require_relative './models/model'

class TodoAppBackend < Sinatra::Base

  Model.setup(settings.environment)

  set :protection, false

  before do
    content_type :json
    headers 'Access-Control-Allow-Origin'  => '*',
            'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST'],
            'Access-Control-Allow-Headers' => 'Content-Type'
  end

  get '/api/todos' do
    Todo.all.to_json
  end

  get '/api/todo/:id' do
    Todo.find(params[:id]).first.to_json
  end

  post '/api/todos' do
    todo = Todo.new(params.slice :body)
    {message: todo.errors.collect(&:to_s)}.to_json unless todo.save
  end

  put '/api/todo/:id' do
    todo = Todo.get(params[:id])
    {message: todo.errors.map(&:to_s)}.to_json unless todo.update(params.slice :body, :done)
  end

  delete '/api/todo/:id' do
    Todo.get(params[:id]).destroy
  end
end
