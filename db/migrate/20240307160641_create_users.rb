# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :chat_id, null: false
      t.string :phone
      t.string :username
      t.boolean :enable_notifications, null: false, default: false

      t.timestamps
    end
  end
end
