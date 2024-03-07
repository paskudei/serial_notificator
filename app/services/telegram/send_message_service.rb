# frozen_string_literal: true

module Telegram
  class SendMessageService < BaseService
    attr_reader :to, :message

    def initialize(to:, message:)
      @to = to
      @message = message
    end

    private

    def request_method
      :post
    end

    def endpoint
      'sendMessage'
    end

    def body
      {
        chat_id: to,
        text: message,
        parse_mode: 'Markdown'
      }
    end
  end
end
