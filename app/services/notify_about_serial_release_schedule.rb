# frozen_string_literal: true

class NotifyAboutSerialReleaseSchedule
  attr_reader :serial_url, :message_recipient

  def initialize(serial_url:, message_recipient:)
    @serial_url = serial_url
    @message_recipient = message_recipient
  end

  def call
    send_message
  end

  private

  def message_builder
    parsed_url = DecomposeSerialUrlService.new(url: serial_url).call
    case parsed_url.host
    when 'animego.org'
      AnimeGo::SerialReleaseScheduleMessageBuilder.new(parsed_url:).call
    else
      raise NotImplementedError
    end
  end

  def send_message
    Telegram::SendMessageService.new(to: message_recipient, message: message_builder).call
  end
end
