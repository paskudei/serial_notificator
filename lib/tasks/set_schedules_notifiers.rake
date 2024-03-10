# frozen_string_literal: true

namespace :set_schedules_notifiers do
  task call: :environment do
    SetSchedulesNotifiersService.new.call
  end
end
