# frozen_string_literal: true

class NotifyAboutSerialReleaseSchedule
  attr_reader :serial_url, :message_recipient_id

  def initialize(serial_url:, message_recipient_id:)
    @serial_url = serial_url
    @message_recipient_id = message_recipient_id
  end

  def call
    send_message
  end

  private

  def message_builder
    case decomposed_url.host
    when 'animego.org'
      AnimeGo::SerialReleaseScheduleMessageBuilder.new(parsed_url: decomposed_url).call
    else
      raise NotImplementedError
    end
  end

  def decomposed_url
    @decomposed_url ||= DecomposeSerialUrlService.new(url: serial_url).call
  end

  def send_message
    Telegram::SendMessageService.new(to: message_recipient_id, message: message_builder).call
  end
end
