require 'pusher'

# Pusher.logger = Rails.logger

pusher_client = Pusher::Client.new(
  app_id: 'APP_ID',
  key: 'APP_KEY',
  secret: 'APP_SECRET',
  cluster: 'APP_CLUSTER',
  encrypted: true
)