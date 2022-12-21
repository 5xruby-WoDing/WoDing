# frozen_string_literal: true

class CreateOpeningTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :opening_times do |t|
      t.time :opening_time
      t.time :closed_time
      t.string :title
      t.belongs_to :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
