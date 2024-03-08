# frozen_string_literal: true

class DecomposeSerialUrlService
  attr_reader :url

  def initialize(url:)
    @url = url
  end

  def call
    parsed_url =
      if url && url =~ URI::DEFAULT_PARSER.make_regexp
        URI.parse(url)
      else
        InvalidUrl.new(host: nil,
                       request_uri: nil)
      end

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

  class InvalidUrl
    attr_reader :host, :request_uri

    def initialize(host:, request_uri:)
      @host = host
      @request_uri = request_uri
    end
  end
end
