# frozen_string_literal: true

class CreateUsersSerials < ActiveRecord::Migration[7.1]
  def change
    create_table :users_serials do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :serial, foreign_key: true, index: true
      t.boolean :is_tracked, null: false, default: true
      t.string :source, null: false
      t.string :url, null: false
      t.string :endpoint, null: false

      t.timestamps
    end
  end
end
