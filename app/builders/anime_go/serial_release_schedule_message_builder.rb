# frozen_string_literal: true

module AnimeGo
  class SerialReleaseScheduleMessageBuilder
    attr_reader :parsed_url, :serial_url, :serial_host, :serial_endpoint

    def initialize(parsed_url:)
      @parsed_url = parsed_url
      @serial_url = parsed_url.original_url
      @serial_host = parsed_url.host
      @serial_endpoint = parsed_url.endpoint.gsub('/anime/', '/')
    end

    def call
      return unless schedule

      schedule_as_text = adapted_schedule.map do |episode|
        "*Номер серии:* #{episode.episode_number}\n" \
          "*Название:* #{episode.title}\n" \
          "*Дата выхода:* #{I18n.l(episode.release_date, format: :long)}\n" \
          "*Статус:* #{episode.is_released ? "\u{2705}" : "\u{274C}"}\n"
      end.join("\n")

      "[#{title} / #{serial_host}](#{serial_url})\n\n" \
        "*График выхода серий:*\n\n" \
        "#{schedule_as_text}"
    end

    private

    def request
      @request ||= AnimeGo::Anime::FetchPageService.new(serial_endpoint:).call
    end

    def title
      AnimeGo::Anime::FetchTitleService.new(html: request.body).call
    end

    def schedule
      AnimeGo::Anime::FetchEpisodeReleaseScheduleService.new(html: request.body).call
    end

    def adapted_schedule
      AnimeGo::Anime::FetchEpisodeReleaseScheduleAdapter.new(schedule:).call
    end
  end
end
