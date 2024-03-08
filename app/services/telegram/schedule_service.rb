# frozen_string_literal: true

module Telegram
  class ScheduleService
    attr_reader :user

    def initialize(user:)
      @user = user
    end

    # @return [Telegram::ScheduleService::Response]
    def call
      Response.new(
        schedules:,
        message:
      )
    end

    private

    def schedules
      user.schedules
    end

    def schedules_times
      return if schedules.blank?

      message = "Список ваших уведомлений:\n"
      message += schedules.map.with_index do |schedule, number|
        "#{number + 1}. *#{schedule.time}*"
      end.join("\n").presence
      message
    end

    def message
      schedules_times ||
        "Ваш список уведомлений пуст\n\n" \
        "Чтобы добавить уведомление, введите команду:\n" \
        '*/add_schedule* 12:00 - Эта команда добавит уведомление, которое будет приходить в то время которое указано.'
    end

    class Response
      attr_reader :schedules, :message

      def initialize(schedules:, message:)
        @schedules = schedules
        @message = message
      end
    end
  end
end
