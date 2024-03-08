# frozen_string_literal: true

module Telegram
  class StartService
    attr_reader :user_params

    def initialize(user_params:)
      @user_params = user_params.with_indifferent_access
    end

    # @return [Telegram::StartService::Response]
    def call
      user = find_or_create_user!

      Response.new(
        user:,
        message: message(user)
      )
    end

    private

    def find_or_create_user!
      User.find_or_create_by!(chat_id: user_params&.[]('id')) do |user|
        user.is_bot = user_params&.[]('is_bot')
        user.first_name = user_params&.[]('first_name')
        user.last_name = user_params&.[]('last_name')
        user.username = user_params&.[]('username')
        user.language_code = user_params&.[]('language_code')
      end
    end

    def message(user)
      message = user.username.present? ? "Привет [@#{user.username}]!" : 'Привет незнакомец!'
      message += "\n\n"
      message += 'Я - Сериальный Напоминатор. '
      message += 'Ты можешь скинуть ссылку на сериал и я буду уведомлять тебя о выходе новых сериях. '
      message += 'А так же, чтобы ты не забывал что уже смотришь!'
      message += "\n\n"
      message += "На текущий момент я поддерживаю работу со следующими сайтами:\n"
      message += '[AnimeGO](https://animego.org/)'
      message += "\n\n"
      message += "Список доступных команд:\n"
      message += "*/add_serial_url* _Ссылка на сериал_ - Эта команда добавит сериал в список отслеживаемых.\n"
      # message += 'Пример: */add_serial_url* https://animego.org/anime/neveroyatnoe-priklyuchenie-dzhodzho-983'
      message += "*/serials_list* - Эта команда покажет все сериалы, которые ты отслеживаешь на данный момент.\n"

      message
    end

    class Response
      attr_reader :user, :message

      def initialize(user:, message:)
        @user = user
        @message = message
      end
    end
  end
end
