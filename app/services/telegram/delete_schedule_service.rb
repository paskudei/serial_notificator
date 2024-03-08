# frozen_string_literal: true

module Telegram
  class DeleteScheduleService
    attr_reader :user, :time

    def initialize(user:, time:)
      @user = user
      @time = time
    end

    # @return [Telegram::DeleteScheduleService::Response]
    def call
      Response.new(message:)
    end

    private

    def schedule
      @schedule ||= Schedule.find_by(user:, time: safe_time)
    end

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

      message =
        if schedule&.destroy
          "Уведомление на *#{safe_time}* удалено!\n\n"
        else
          "Уведомление на *#{safe_time}* не найдено!\n\n"
        end

      if user.schedules.present?
        message += "Список ваших уведомлений:\n"
        message += user.schedules.reload.order(:time).map.with_index do |schedule, number|
          "#{number + 1}. #{schedule.time}"
        end.join("\n")
      else
        message +=
          "Ваш список уведомлений пуст\n\n" \
          "Чтобы добавить уведомление, введите команду:\n" \
          '*/add_schedule* 12:00 - Эта команда добавит уведомление, которое будет приходить в то время которое указано.'
      end

      message
    end

    class Response
      attr_reader :message

      def initialize(message:)
        @message = message
      end
    end
  end
end
