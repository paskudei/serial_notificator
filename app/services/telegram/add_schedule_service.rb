# frozen_string_literal: true

module Telegram
  class AddScheduleService
    attr_reader :user, :time

    def initialize(user:, time:)
      @user = user
      @time = time
    end

    # @return [Telegram::AddScheduleService::Response]
    def call
      schedule = Schedules::CreateService.new(user:, time: safe_time).call

      Response.new(
        schedule:,
        message:
      )
    end

    private

    def safe_time
      safe_time = time&.split(':')
      return unless safe_time

      return unless Time.now.change(hour: safe_time[0] || 0, min: safe_time[1] || 0)

      "#{safe_time[0] || '00'}:#{safe_time[1] || '00'}"
    rescue ArgumentError
      nil
    end

    def message
      return 'Некорректное время' unless safe_time

      message = "Ежедневное уведомление на *#{safe_time}* установлено!\n\n"
      message += "Список ваших уведомлений:\n"
      message += user.schedules.order(:time).map.with_index do |schedule, number|
        "#{number + 1}. #{schedule.time}"
      end.join("\n")

      message
    end

    class Response
      attr_reader :schedule, :message

      def initialize(schedule:, message:)
        @schedule = schedule
        @message = message
      end
    end
  end
end
