# frozen_string_literal: true

module AnimeGo
  module Anime
    class FetchEpisodeReleaseScheduleAdapter
      attr_reader :schedule

      def initialize(schedule:)
        @schedule = schedule
      end

      def call
        schedule.map do |episode|
          Adapter.new(
            episode_number: episode[0],
            title: episode[1].strip,
            release_date: string_to_date(episode[2]),
            is_released: episode[3]
          )
        end
      end

      private

      def string_to_date(release_date)
        release_date
          .gsub(' января ', '.01.')
          .gsub(' февраля ', '.02.')
          .gsub(' марта ', '.03.')
          .gsub(' апреля ', '.04.')
          .gsub(' мая ', '.05.')
          .gsub(' июня ', '.06.')
          .gsub(' июля ', '.07.')
          .gsub(' августа ', '.08.')
          .gsub(' сентября ', '.09.')
          .gsub(' октября ', '.10.')
          .gsub(' ноября ', '.11.')
          .gsub(' декабря ', '.12.')
          .to_date
      end

      class Adapter
        attr_reader :episode_number, :title, :release_date, :is_released

        def initialize(episode_number:, title:, release_date:, is_released:)
          @episode_number = episode_number
          @title = title
          @release_date = release_date
          @is_released = is_released
        end
      end
    end
  end
end
