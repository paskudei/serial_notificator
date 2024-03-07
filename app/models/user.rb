# frozen_string_literal: true

class User < ApplicationRecord
  has_many :requests, dependent: :destroy

  has_many :users_serials, dependent: :destroy
  has_many :serials, through: :users_serials

  validates :chat_id, presence: true, uniqueness: true
end
