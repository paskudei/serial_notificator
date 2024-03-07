# frozen_string_literal: true

module UsersSerials
  class CreateService
    attr_reader :user, :serial, :url

    def initialize(user:, serial:, url:)
      @user = user
      @serial = serial
      @url = url
    end

    def call
      create_users_serial!
    end

    private

    def create_users_serial!
      UsersSerial.create!(user:, serial:, is_tracked: true, source:, url:, endpoint:)
    end

    def decomposed_url
      @decomposed_url ||= DecomposeSerialUrlService.new(url:).call
    end

    def source
      case decomposed_url.host
      when 'animego.org'
        'animego'
      end
    end

    def endpoint
      case decomposed_url.host
      when 'animego.org'
        decomposed_url.endpoint.gsub('/anime/', '/')
      end
    end
  end
end
