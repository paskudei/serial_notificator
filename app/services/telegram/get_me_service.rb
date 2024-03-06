# frozen_string_literal: true

# Тест сервис для интеграции с телеграмом
module Telegram
  class GetMeService < BaseService
    private

    def request_method
      :get
    end

    def endpoint
      'getMe'
    end
  end
end
