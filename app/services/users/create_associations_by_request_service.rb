# frozen_string_literal: true

module Users
  class CreateAssociationsByRequestService
    attr_reader :user, :request

    def initialize(user:, request:)
      @user = user
      @request = request
    end

    def call
      if users_serial
        users_serial.update!(is_tracked: true)
      else
        serial = Serial.find_or_create_by!(title:)
        users_serial = UsersSerials::CreateService.new(user:, serial:, url:).call
        NotifyAboutSerialReleaseSchedule.new(serial_url: users_serial.url, message_recipient_id: user.chat_id).call
      end
    end

    private

    def users_serial
      @users_serial ||= UsersSerial.find_by(user:, url:)
    end

    def title
      @title ||= SerialTitleBuilder.new(url:).call
    end

    def url
      request.url
    end

    def decomposed_url
      @decomposed_url ||= DecomposeSerialUrlService.new(url:).call
    end
  end
end
