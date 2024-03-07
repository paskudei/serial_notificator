# frozen_string_literal: true

module AnimeGo
  module Anime
    class FetchTitleService
      attr_reader :html

      def initialize(html:)
        @html = html
      end

      def call
        Nokogiri::HTML(html).xpath("//div[@class='anime-title']")[0].children[0].children[0].text
      end
    end
  end
end
