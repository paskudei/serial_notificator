# frozen_string_literal: true

class Serial < ApplicationRecord
  has_many :users_serials, dependent: :destroy
  has_many :users, through: :users_serials

  validates :title, presence: true, uniqueness: true
end
