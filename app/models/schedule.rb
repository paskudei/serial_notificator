# frozen_string_literal: true

class Schedule < ApplicationRecord
  belongs_to :user

  validates :time, presence: true, uniqueness: { scope: [:user_id] }
end
