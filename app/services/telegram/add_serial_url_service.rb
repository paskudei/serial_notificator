# frozen_string_literal: true

module Telegram
  class AddSerialUrlService
    attr_reader :user, :url

    def initialize(user:, url:)
      @user = user
      @url = url
    end

    # @return [Telegram::AddSerialUrlService::Response]
    def call
      request = Requests::CreateService.new(user:, url:).call
      users_serial = UsersSerial.find_by(user:, url:)

      if users_serial
        users_serial.update(is_tracked: true)
      else
        serial = Serial.find_or_create_by(title:)
        users_serial = UsersSerials::CreateService.new(user:, serial:, url:).call
      end

      Response.new(
        request:,
        serial:,
        users_serial:,
        message:
      )
    end

    private

    def title
      @title ||= SerialTitleBuilder.new(url:).call
    end

    def decomposed_url
      @decomposed_url ||= DecomposeSerialUrlService.new(url:).call
    end

    def message
      return 'Некорректная ссылка' unless title

      case decomposed_url.host
      when 'animego.org'
        AnimeGo::SerialReleaseScheduleMessageBuilder.new(parsed_url: decomposed_url).call
      else
        raise NotImplementedError
      end
    end

    class Response
      attr_reader :request, :serial, :users_serial, :message

      def initialize(request:, serial:, users_serial:, message:)
        @request = request
        @serial = serial
        @users_serial = users_serial
        @message = message
      end
    end
  end
end
