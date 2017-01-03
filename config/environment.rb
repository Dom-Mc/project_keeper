# environment.rb file: will connect files in our app with each other and to our various gems (via bundler)

# Setup environment
ENV['SINATRA_ENV'] ||= "development"

# Setup bundler
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

if development?
  set :database, {
    adapter: "sqlite3",
    database: "db/development.sqlite3"
  }
else
  set :database, ENV['DATABASE_URL']
end

require_all 'app'
