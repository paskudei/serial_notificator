# frozen_string_literal: true

class SerialTitleBuilder
  attr_reader :url

  def initialize(url:)
    @url = url
  end

  def call
    case decomposed_url.host
    when 'animego.org'
      page = AnimeGo::Anime::FetchPageService.new(serial_endpoint: decomposed_url.endpoint.gsub('/anime/', '/')).call
      AnimeGo::Anime::FetchTitleService.new(html: page.body).call
    else
      raise NotImplementedError
    end
  end

  private

  def decomposed_url
    @decomposed_url ||= DecomposeSerialUrlService.new(url:).call
  end
end
