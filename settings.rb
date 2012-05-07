configure do
  set :method_override, true # For HTTP verbs
  set :logging, false # stops annoying double log messages.
  set :static, false # see config.ru for dev mode static file serving
  set :asset_timestamps, false
end

configure :development do
  set :db, 'sqlite3://' + settings.root + '/db/development.sqlite3'
  set :raise_errors, true
  set :show_exceptions, true
  set :static_paths, ['/css', '/img', '/js', '/less', '/robots.txt', '/favicons.ico']
end

configure :production do
  set :db, 'mysql://user:password@hostname/database'
  set :raise_errors, false
  set :show_exceptions, false
end

# Rack configuration
# Serve static files in dev
if settings.development?
  use Rack::Static, :urls => settings.static_paths, :root => "public"
end

use Rack::Session::Cookie, :key => 'pager.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => 'change_me_in_production'


# Authentication middleware
# https://github.com/hassox/warden/wiki/overview
use Warden::Manager do |mgmt|
  mgmt.default_strategies :password
  mgmt.failure_app = Sinatra::Application
end


# Database
# http://datamapper.rubyforge.org/dm-core/DataMapper.html
DataMapper.setup(:default, settings.db)
DataMapper::Property::String.length(255)
DataMapper::Logger.new($stdout, :info) if settings.development?
