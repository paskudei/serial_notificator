# frozen_string_literal: true

module Telegram
  class SerialsService
    attr_reader :user

    def initialize(user:)
      @user = user
    end

    # @return [Telegram::SerialsService::Response]
    def call
      Response.new(
        serials: users_serials,
        message:
      )
    end

    private

    def users_serials
      @users_serials ||= user.users_serials
    end

    def serials_titles
      serial_sources = users_serials.map(&:source).uniq
      message = ''
      serial_sources.map do |serial_source|
        message += "#{serial_source_as_url(serial_source)}\n"
        message += users_serials.where(source: serial_source).map.with_index do |user_serial, number|
          "#{number + 1}. [#{user_serial.serial.title}](#{user_serial.url})"
        end.join("\n")
      end

      message.presence
    end

    def serial_source_as_url(serial_source)
      case serial_source
      when 'animego'
        '[AnimeGO](https://animego.org/)'
      end
    end

    def message
      serials_titles ||
        "Ваш список сериалов пуст\n\n" \
        "Чтобы добавить сериал, введите команду:\n" \
        '*/add_serial_url* _Ссылка на сериал_ - Эта команда добавит сериал в список отслеживаемых.'
    end

    class Response
      attr_reader :serials, :message

      def initialize(serials:, message:)
        @serials = serials
        @message = message
      end
    end
  end
end
