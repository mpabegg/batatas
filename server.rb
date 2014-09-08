require './database'
require 'sinatra/json'
require 'json'

Dir[File.dirname(__FILE__) + '/app/models/**'].each { |model| require model }
Dir[File.dirname(__FILE__) + '/app/routes/**'].each { |route| require route }

helpers do
  def logger
    request.logger
  end
end

before do
  content_type 'application/json'
end


# Copied form https://raw.githubusercontent.com/macedo/sinatra-contrib/master/lib/sinatra/request_logger.rb
unless ENV['RACK_ENV'] == 'production'
  set :logging, true
  before do
    request_query_string = if request.query_string.empty?
                             request.query_string
                           else
                             "?#{request.query_string}"
                           end

    logger.info(
        "Starting #{request.request_method} #{request.path}#{request_query_string} for #{request.ip}"
    )
    logger.info("Request Body: #{request.body.read}")
  end

  after do
    if response.body.respond_to? :join
      logger.info("Response: #{response.body.join("")}")
    end
    logger.info("Completed #{request.request_method} #{request.path} with status #{response.status}")
  end
end