# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

Rails.application.config do |config|
  config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }
  config.session_store :cache_store, key: '_serial_notificator_session', expire_after: 1.day
end
