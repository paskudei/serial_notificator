# frozen_string_literal: true

module Schedules
  class CreateService
    attr_reader :user, :time

    def initialize(user:, time:)
      @user = user
      @time = time
    end

    def call
      create_schedule!
    end

    private

    def create_schedule!
      Schedule.create(user:, time:)
    end
  end
end
