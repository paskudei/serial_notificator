# frozen_string_literal: true

class SerialReleaseScheduleBuilder
  attr_reader :url

  def initialize(url:)
    @url = url
  end

  def call
    case decomposed_url.host
    when 'animego.org'
      AnimeGo::SerialReleaseScheduleMessageBuilder.new(parsed_url: decomposed_url).call
    else
      raise NotImplementedError
    end
  end

  private

  def decomposed_url
    @decomposed_url ||= DecomposeSerialUrlService.new(url:).call
  end
end
