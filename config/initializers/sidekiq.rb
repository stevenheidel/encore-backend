Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_ADDRESS'] }

  config.server_middleware do |chain|
    chain.add Kiqstand::Middleware
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_ADDRESS'] }
end