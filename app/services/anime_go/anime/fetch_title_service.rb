# frozen_string_literal: true

module AnimeGo
  module Anime
    class FetchTitleService
      attr_reader :html_page

      def initialize(html_page:)
        @html_page = html_page
      end

      def call
        Nokogiri::HTML(html_page).xpath("//div[@class='anime-title']")[0].children[0].children[0].text
      end
    end
  end
end
