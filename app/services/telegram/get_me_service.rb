# frozen_string_literal: true

# Тест сервис для интеграции с телеграмом
module Telegram
  class GetMeService < BaseService
    def call
      Faraday.get(service_url)
    end
  end
end
