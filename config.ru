# config.ru: Load application environment, code, and libraries

require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# Ensure your app properly handles patch and delete requests
use Rack::MethodOverride

# Mount application controller (creates an instance of our ApplicationController class that can respond to requests from a clien)

run ApplicationController
