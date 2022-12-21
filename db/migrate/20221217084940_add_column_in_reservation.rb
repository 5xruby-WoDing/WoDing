# frozen_string_literal: true

class AddColumnInReservation < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :end_time, :time
  end
end
