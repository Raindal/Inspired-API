require 'rspec'
require 'rack/test'
require './inspired'

Dir[File.dirname(__FILE__) + '/helpers/*.rb'].each { |file| require file }

set :database, { adapter: 'sqlite3', database: 'db/test.sqlite3' }

ActiveRecord::Base.logger.level = 1

def app
  Sinatra::Application
end

RSpec.configure do |c|
  c.before do
    Video.delete_all
  end
  c.include Rack::Test::Methods
end