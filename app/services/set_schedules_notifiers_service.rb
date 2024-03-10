# frozen_string_literal: true

class SetSchedulesNotifiersService
  def call
    Schedule.find_each do |schedule|
      next if schedule_time(schedule) < DateTime.now

      NotifyUserAboutSerialsJob.perform_at(schedule_time(schedule), schedule.user_id)
    end
  end

  private

  def schedule_time(schedule)
    time = schedule.time.split(':')
    DateTime.now.change(hour: time[0].to_i, min: time[1].to_i)
  end
end
