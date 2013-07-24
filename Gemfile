source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.4.2'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'metric_fu'

  # Guard
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-cucumber'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-shell'
  gem 'guard-spin'
  gem 'guard-zeus'

  gem 'heroku_san'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'bullet'
  gem 'debugger'

  # RSpec
  gem 'rspec-rails', '~> 2.13'
end

group :test do
  # RSpec friends
  gem 'capybara', '2.0.2'
  gem 'vcr'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'rack-test'
  gem 'database_cleaner'

  # Cucumber
  gem 'cucumber-rails', github: 'cucumber/cucumber-rails', branch: 'master_rails4_test', require: false
  gem 'cucumber', '= 1.3.2' # needs to be locked at 1.3.2 because https://github.com/cucumber/cucumber/issues/501
  gem 'cucumber-api-steps', require: false
  gem 'cucumber_factory'
  gem 'relish'
end

group :profile do
  gem 'ruby-prof'
end

# Use MongoDB as the database
gem 'mongoid', github: 'mongoid/mongoid'
gem 'mongoid-paranoia', github: 'simi/mongoid-paranoia'

# Use Unicorn as the app server
gem 'unicorn'
gem 'unicorn-rails'

# Use Slim for HTML templates
gem 'slim-rails'

# Template for demo frontend
gem 'htmlkickstart'

# Social APIs
gem 'koala' # for Facebook
gem 'foursquare2'
gem 'flickraw', require: false
gem 'youtube_it'

# Rails Admin
gem 'rails_admin', github: 'sferik/rails_admin'
gem 'devise', '~> 3.0.0.rc'
gem 'safe_yaml', github: 'dtao/safe_yaml' # see: http://codedecoder.wordpress.com/2013/05/31/cannot-load-such-file-safe_yaml-rails_admin/

# Faraday
gem 'faraday'
gem 'faraday_middleware'
gem 'hashie'
gem 'typhoeus'

# Sidekiq
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', require: nil
gem 'kiqstand', github: 'mongoid/kiqstand' # to make it work nicely with Mongoid
gem 'sidekiq_status'

# Paperclip
gem 'paperclip'
gem 'fog'
gem 'mongoid-paperclip', require: 'mongoid_paperclip'

# New Relic
gem 'newrelic_rpm'

# Whenever
gem 'whenever', github: 'iTakeshi/whenever', branch: 'rails4'

gem 'google_timezone'
gem 'geocoder'
