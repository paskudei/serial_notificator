# frozen_string_literal: true

class DecomposeSerialUrlService
  attr_reader :url

  def initialize(url:)
    @url = url
  end

  def call
    parsed_url = URI.parse(url)
    Adapter.new(
      original_url: url,
      host: parsed_url.host,
      endpoint: parsed_url.request_uri
    )
  end

  class Adapter
    attr_reader :original_url, :host, :endpoint

    def initialize(original_url:, host:, endpoint:)
      @original_url = original_url
      @host = host
      @endpoint = endpoint
    end
  end
end
