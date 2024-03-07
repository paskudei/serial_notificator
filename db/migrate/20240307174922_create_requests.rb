# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.string :url

      t.timestamps
    end
  end
end
