require 'pusher'

Pusher.app_id = 'APP_ID'
Pusher.key = 'APP_KEY'
Pusher.secret = 'APP_SECRET'
Pusher.cluster = 'APP_CLUSTER'
Pusher.logger = Rails.logger
Pusher.encrypted = true

pusher_client = Pusher::Client.new(
  app_id: 'APP_ID',
  key: 'APP_KEY',
  secret: 'APP_SECRET',
  cluster: 'APP_CLUSTER',
)