# frozen_string_literal: true

module AnimeGo
  module Anime
    class FetchFullPageService
      attr_reader :serial_endpoint

      def initialize(serial_endpoint:)
        @serial_endpoint = serial_endpoint
      end

      def call
        Faraday.get("https://animego.org/anime/#{serial_endpoint}")
      end
    end
  end
end
