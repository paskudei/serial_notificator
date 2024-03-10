# frozen_string_literal: true

module AnimeGo
  module Anime
    class FetchPageService
      attr_reader :serial_endpoint

      def initialize(serial_endpoint:)
        @serial_endpoint = serial_endpoint
      end

      def call
        raise Error, Nokogiri::HTML(request.body) unless request.success?

        request
      end

      private

      def request
        @request ||= Faraday.get("https://animego.org/anime#{serial_endpoint}")
      end

      class Error < StandardError
      end
    end
  end
end
