# frozen_string_literal: true

module Telegram
  class WebhookController < Telegram::Bot::UpdatesController
    def start!(_word = nil, *_other_words)
      start_service = Telegram::StartService.new(user_params: from).call
      render_text_message(start_service.message)
    end
    alias help! start!

    def add_serial_url!(url = nil)
      add_serial_url_service = Telegram::AddSerialUrlService.new(user: current_user, url:).call
      render_text_message(add_serial_url_service.message)
    end

    def serials_list!
      serials_list_service = Telegram::SerialsListService.new(user: current_user).call
      render_text_message(serials_list_service.message)
    end

    private

    def current_user
      @current_user ||= User.find_by(chat_id: from['id'])
    end

    def render_text_message(message)
      respond_with :message, text: message, parse_mode: 'Markdown'
    end
  end
end
