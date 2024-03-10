# frozen_string_literal: true

module AnimeGo
  module Anime
    class FetchEpisodeReleaseScheduleService
      attr_reader :html

      def initialize(html:)
        @html = html
      end

      def call
        raise Error, html_document unless episode_release_schedule_div

        episode_release_schedule_div.map do |episode_div|
          episode_div_info = episode_div.children[0].children[0].children
          result = episode_div_info.first(3).map(&:text)
          result << episode_div_info.last.children[0].present? ? true : false
          result
        end
      end

      private

      def html_document
        Nokogiri::HTML(html)
      end

      def episode_release_schedule_div
        html_document
          &.xpath("//div[@class='row released-episodes-container']")&.[](0)
          &.children
          &.first(3)
      end

      class Error < StandardError
      end
    end
  end
end
