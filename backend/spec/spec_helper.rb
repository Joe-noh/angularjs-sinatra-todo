ENV['RACK_ENV'] = "test"

require_relative '../server'
require 'rspec'
require 'rack/test'

set :environment, :test
set :raise_errors, true
set :logging, false

def app
  TodoAppBackend
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

## fixture
include DataMapper::Sweatshop::Unique

Todo.fix {
  { :body => unique(:key){ /[:sentence:]/.gen } }
}
