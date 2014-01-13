require 'sidekiq'
require 'sidekiq-status'

Sidekiq.configure_client do |config|
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end

Sidekiq.configure_server do |config|
  if defined?(ActiveRecord::Base)
    db_config = Rails.application.config.database_configuration[Rails.env]
    db_config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
    db_config['pool']              = ENV['SIDEKIQ_DB_POOL'] || 20
    ActiveRecord::Base.establish_connection(db_config)
  end

  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes # default
  end
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end