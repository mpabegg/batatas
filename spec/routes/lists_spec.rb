require 'rspec'
require 'rack/test'
require_relative '../../server'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'GET lists/:id' do
  it 'succeeds' do
    get 'lists/1'
    expect(last_response.status).to be 200
  end
end