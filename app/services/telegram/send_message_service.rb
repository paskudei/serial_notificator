# frozen_string_literal: true

module Telegram
  class SendMessageService < BaseService
    attr_reader :to, :message

    def initialize(to:, message:)
      @to = to
      @message = message
    end

    def call
      Faraday.post(service_url) do |request|
        request.body = body
      end
    end

    private

    def body
      {
        chat_id: to,
        text: message
      }
    end
  end
end
