# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :chat_id, null: false
      t.boolean :is_bot, null: false, default: false
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :language_code
      t.boolean :enable_notifications, null: false, default: false

      t.timestamps
    end
  end
end
