# frozen_string_literal: true

class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|
      t.integer :kind
      t.integer :capacity
      t.integer :deposit, default: 0
      t.string :state, default: 'vacancy'
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
