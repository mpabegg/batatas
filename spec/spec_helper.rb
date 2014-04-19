require 'rspec'
require 'rack/test'
require_relative '../server'

include Rack::Test::Methods

def app
  Sinatra::Application
end
