# environment.rb file: will connect files in our app with each other and to our various gems (via bundler)

# Setup environment
ENV['SINATRA_ENV'] ||= "development"

# Setup bundler
require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
# ActiveRecord::Base.establish_connection(
#    :adapter => "sqlite3",
#    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )

require_all 'app'
