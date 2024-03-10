# frozen_string_literal: true

module AnimeGo
  module Anime
    class FetchTitleService
      attr_reader :html

      def initialize(html:)
        @html = html
      end

      def call
        raise Error, html_document unless fetch_title

        fetch_title
      end

      private

      def html_document
        Nokogiri::HTML(html)
      end

      def fetch_title
        html_document&.xpath("//div[@class='anime-title']")&.[](0)
                     &.children&.[](0)
                     &.children&.[](0)
                     &.text
      end

      class Error < StandardError
      end
    end
  end
end
