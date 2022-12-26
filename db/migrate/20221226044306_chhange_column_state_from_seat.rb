class ChhangeColumnStateFromSeat < ActiveRecord::Migration[6.1]
  def change
    remove_column :seats, :state
  end
end
