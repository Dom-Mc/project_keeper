# Rakefile: rake (ruby make) is a package that makes it easy to create files & folders, and to setup varuious automated tasks.

# Type `rake -T` on your command line to see the available rake tasks.

ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

# Type `rake console` to open a new console session

task :console do
  Pry.start
end
