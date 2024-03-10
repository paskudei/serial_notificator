# frozen_string_literal: true

class NotifyUserAboutSerialsJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find(user_id)
    Telegram.bot.send_message(chat_id: user.chat_id, text: 'Сейчас будет ежедневное уведомление!')
    user.users_serials.each do |users_serial|
      message = SerialReleaseScheduleBuilder.new(url: users_serial.url).call
      Telegram.bot.send_message(chat_id: user.chat_id, text: message, parse_mode: 'Markdown')
    end
  end
end
