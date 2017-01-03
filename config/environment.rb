# environment.rb file: will connect files in our app with each other and to our various gems (via bundler)

# Setup environment
ENV['SINATRA_ENV'] ||= "development"

# Setup bundler
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

configure :development do
  set :database, 'sqlite3:db/development.sqlite3'
end

configure :production do
  set :database, ENV['DATABASE_URL']
end

# DB = Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://database.db')
# Setup database connection
# ActiveRecord::Base.establish_connection(
#
#   # adapter: db.scheme == 'postgres' ? 'postgresql' : db.scheme,
#   :adapter => "sqlite3",
#   :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
#   # :database => "db/development.sqlite"
# )

require_all 'app'
