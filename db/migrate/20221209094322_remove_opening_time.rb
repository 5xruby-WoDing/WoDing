# frozen_string_literal: true

class RemoveOpeningTime < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :start_time, :time
    add_column :restaurants, :end_time, :time
  end
end
