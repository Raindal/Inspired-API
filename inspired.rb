require 'newrelic_rpm' if ENV['RACK_ENV'] == 'production'

require 'sinatra'
require 'sinatra/activerecord'
require 'net/http'
require './config/database'

Dir[File.dirname(__FILE__) + '/app/models/*.rb'].each { |file| require file }

require './lib/youtube'
require './lib/inspired'
require './config/routes'

after do
  ActiveRecord::Base.connection.close
end
