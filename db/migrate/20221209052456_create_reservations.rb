# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.string :serial
      t.string :name
      t.string :phone
      t.string :email
      t.integer :gender, default: 0
      t.time :arrival_time
      t.string :state, default: 'pending'
      t.datetime :deleted_at
      t.integer :adult_quantity, default: 1
      t.integer :child_quantity, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.references :seat, null: false, foreign_key: true

      t.timestamps
    end
    add_index :reservations, :deleted_at
  end
end
