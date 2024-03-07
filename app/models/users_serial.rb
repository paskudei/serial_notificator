# frozen_string_literal: true

class UsersSerial < ApplicationRecord
  belongs_to :user
  belongs_to :serial

  enum source: {
    animego: 'animego'
  }, _prefix: true

  validates :source, presence: true
  validates :url, presence: true, uniqueness: { scope: %i[user_id serial_id] }
  validates :endpoint, presence: true
end
