ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require_relative '../server'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each { |f| require f }

include Rack::Test::Methods

def app
  Sinatra::Application
end

RSpec.configure do |c|
  c.around(:each) do |example|
    Sequel::Model.db.transaction(:rollback => :always, :auto_savepoint => true) { example.run }
  end
end
