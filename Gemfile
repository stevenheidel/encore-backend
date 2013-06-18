source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc2'

# Use SCSS for stylesheets
gem 'sass-rails', '4.0.0.rc2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.4.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use unicorn as the app server
gem 'unicorn'

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'metric_fu'

  # Guard
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-spin'
  gem 'guard-zeus'
end

group :development, :test do
  gem 'bullet'
  gem 'debugger'
end

group :test do
  # RSpec
  gem 'rspec-rails', "~> 2.13"
  gem 'capybara', "2.0.2"
  gem 'vcr'
  gem "factory_girl_rails", "~> 4.0"
  gem 'test_after_commit'
  gem 'rack-test'

  # Cucumber
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end

group :staging do
  gem 'mysql2'
end

group :production do
  gem 'mysql2'
end

# Use HAML for HTML templates
gem 'haml'

# Template for demo frontend
gem 'htmlkickstart'

# Social APIs
gem 'instagram'
gem 'koala' # for Facebook
gem 'twitter'
gem 'foursquare2'
gem 'flickraw'

# Using Rails 4 branch of Rails Admin
gem 'rails_admin', github: 'sferik/rails_admin', branch: 'rails-4'
gem 'font-awesome-sass-rails' # TODO Temporary see: https://github.com/sferik/rails_admin/issues/1443
gem 'devise'
gem 'protected_attributes'

# Faraday
gem 'faraday'
gem 'faraday_middleware'
gem 'hashie'
gem 'typhoeus'

# Sidekiq
gem 'sidekiq'
gem 'slim', ">= 1.3.0"
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'clockwork'

# Paperclip
gem 'paperclip', github: 'thoughtbot/paperclip'