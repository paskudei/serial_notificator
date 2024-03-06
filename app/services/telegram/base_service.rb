# frozen_string_literal: true

module Telegram
  class BaseService
    def call
      connection = Faraday.new(
        url: "https://api.telegram.org/bot#{token}/#{endpoint}"
      )

      case request_method
      when :get, :head, :delete, :trace
        connection.send(request_method)
      when :post, :put, :patch
        connection.send(request_method) do |request|
          request.body = body
        end
      else
        raise NotImplementedError, "Undefined HTTP request method `#{request_method}`"
      end
    end

    private

    def request_method
      raise NotImplementedError
    end

    def token
      Rails.application.credentials.telegram_bot[:token]
    end

    def endpoint
      raise NotImplementedError
    end

    def body
      {}
    end
  end
end
