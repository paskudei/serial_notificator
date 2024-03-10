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

      schedule_as_text = ''
      adapted_schedule.map do |episode|
        release_date = I18n.l(episode.release_date, format: :long)
        schedule_as_text += "*Номер серии:* #{episode.episode_number}\n"
        schedule_as_text += "*Название:* #{episode.title}\n"
        schedule_as_text += "*Дата выхода:* #{release_date}"
        if episode.release_date > DateTime.now.to_date &&
           episode.release_date.between?(DateTime.now.to_date - 3.days, DateTime.now.to_date)
          schedule_as_text += " \u{2b05} #{days_count_to_release(episode.release_date)}"
        end
        schedule_as_text +=  "\n"
        schedule_as_text +=  "*Статус:* #{episode.is_released ? "\u{2705}" : "\u{274C}"}\n"
        schedule_as_text += "\n"
      end

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

    def days_count_to_release(release_date)
      date_range = release_date - DateTime.now.to_date
      days_count =
        if date_range.to_i.zero?
          0
        else
          date_range.in_days.to_i
        end

      I18n.t(:left_x_days, scope: 'datetime.distance_in_words', count: days_count).to_s
    end
  end
end
