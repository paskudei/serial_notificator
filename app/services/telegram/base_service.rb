# frozen_string_literal: true

module Telegram
  class BaseService
    def call
      raise NotImplementedError
    end

    private

    # URL запроса формируется из доменного имени, токена бота и эндпоинта
    def service_url
      "https://api.telegram.org/bot#{token}/#{endpoint}"
    end

    def token
      Rails.application.credentials.telegram_bot[:token]
    end

    # Эндпоинт формируется автоматически из названия сервиса.
    # Например, для запроса на получение информации о боте, необходимо указать эндпоинт /getMe
    # Сервис, который будет отвечать за запрос в этот URL должен иметь имя как GetMeService
    def endpoint
      self.class.to_s.gsub('Service', '').split('::').last
    end
  end
end
