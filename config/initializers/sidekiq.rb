# Set up Redis connection on Cloud 66
if Rails.env.production?
  redis_address = "redis://#{ENV['REDIS_ADDRESS']}:6379/"
else
  redis_address = nil
end

Sidekiq.configure_server do |config|
  config.redis = { url: redis_address }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_address }
end