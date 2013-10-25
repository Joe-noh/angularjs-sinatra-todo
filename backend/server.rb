require 'bundler'
Bundler.require

require 'json'

class App < Sinatra::Base

  set :protection, false

  before do
    content_type :json 
    headers 'Access-Control-Allow-Origin'  => '*',
            'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST'],
            'Access-Control-Allow-Headers' => 'Content-Type'
  end
  
  get '/api/todo/:id' do
    [{name: 'jack', age: 25}].to_json
  end
end
