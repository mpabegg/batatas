require './database'
require 'sinatra/json'
require 'json'

Dir[File.dirname(__FILE__) + '/app/models/**'].each { |model| require model }
# Load all route files
Dir[File.dirname(__FILE__) + '/app/routes/**'].each { |route| require route }

helpers do
  def logger
    request.logger
  end
end