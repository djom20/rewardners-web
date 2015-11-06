require 'capistrano/setup'
require 'capistrano/deploy'
# require 'capistrano/secrets_yml'
# require 'whenever/capistrano'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/puma'
require 'capistrano/puma/workers'
require 'capistrano/puma/jungle'
require 'capistrano/puma/monit'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
