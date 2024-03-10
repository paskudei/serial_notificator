# frozen_string_literal: true

class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.string :time, null: false

      t.timestamps
    end
  end
end
