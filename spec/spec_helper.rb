ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require_relative '../server'

include Rack::Test::Methods

def app
  Sinatra::Application
end

RSpec.configure do |c|
  c.around(:each) do |example|
    Sequel::Model.db.transaction(:rollback=>:always, :auto_savepoint=>true){example.run}
  end
end
