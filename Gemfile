source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc1'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '4.0.0.rc1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use unicorn as the app server
gem 'unicorn'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'annotate', ">= 2.5.0"

  gem "flay"
  gem "rails_best_practices"
  gem "reek"

  # Guard
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-spin'
  gem 'guard-zeus'
  # gem 'guard-livereload' look into setting up
end

group :development, :test do
  gem 'rspec-rails', "~> 2.13"

  gem 'debugger'
end

group :test do
  gem 'capybara', "2.0.2"

  gem 'vcr'

  gem "factory_girl_rails", "~> 4.0"

  gem 'test_after_commit'

  gem 'rack-test'
end

group :production do
  
end

# Use HAML for HTML templates
gem 'haml'

# Social APIs
gem 'instagram'
gem 'koala' # for Facebook
gem 'twitter'

# RABL views
gem 'rabl'
gem 'oj' # Also add either `oj` or `yajl-ruby` as the JSON parser

# Using Rails 4 branch of Rails Admin
gem 'rails_admin', github: 'sferik/rails_admin', branch: 'rails-4'
gem 'font-awesome-sass-rails' # TODO Temporary see: https://github.com/sferik/rails_admin/issues/1443
gem 'devise'
gem 'protected_attributes'

# Faraday
gem 'faraday'
gem 'faraday_middleware'
gem 'hashie'

# Sidekiq
gem 'sidekiq'
gem 'slim', ">= 1.3.0"
gem 'sinatra', '>= 1.3.0', :require => nil

gem 'paperclip', github: 'thoughtbot/paperclip'