require 'pusher'

# Pusher.logger = Rails.logger

Pusher.app_id = ENV['APP_ID']
Pusher.key = ENV['APP_KEY']
Pusher.secret = ENV['APP_SECRET']
Pusher.logger = Rails.logger
Pusher.encrypted = true