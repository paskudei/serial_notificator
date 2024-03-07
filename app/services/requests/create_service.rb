# frozen_string_literal: true

module Requests
  class CreateService
    attr_reader :user, :url

    def initialize(user:, url:)
      @user = user
      @url = url
    end

    def call
      create_request!
    end

    private

    def create_request!
      Request.create!(user:, url:)
    end
  end
end
