# frozen_string_literal: true

class AddColumnArrivalDate < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :arrival_date, :date
  end
end
