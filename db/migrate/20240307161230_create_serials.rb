# frozen_string_literal: true

class CreateSerials < ActiveRecord::Migration[7.1]
  def change
    create_table :serials do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
