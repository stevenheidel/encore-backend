source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', github: 'rails/rails'

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
  #gem 'bullet'
  gem 'debugger'

  # RSpec
  # TODO: this issue: https://github.com/rspec/rspec-rails/pull/772
  gem 'rspec-rails', '~> 2.14'
end

group :test do
  # RSpec friends
  gem 'capybara', '2.0.2'
  gem 'vcr'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'rack-test'
  gem 'database_cleaner'
  gem 'timecop'

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

# Use PostgreSQL as the database
gem 'pg'
gem 'annotate'

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
#gem 'rails_admin', github: 'sferik/rails_admin'
#gem 'devise', '~> 3.0.0.rc'
gem 'safe_yaml'

# Faraday
gem 'faraday'
gem 'faraday_middleware'
gem 'hashie'
gem 'typhoeus'

# Sidekiq
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', require: nil
gem 'sidekiq_status'

# Paperclip
gem 'paperclip'
gem 'fog'

# New Relic
gem 'newrelic_rpm'

# Whenever
gem 'whenever', github: 'iTakeshi/whenever', branch: 'rails4'

gem 'google_timezone'
gem 'geocoder'

# Paginate 
#gem 'will_paginate'

gem "twitter-bootstrap-rails"