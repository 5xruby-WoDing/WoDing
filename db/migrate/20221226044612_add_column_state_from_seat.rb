class AddColumnStateFromSeat < ActiveRecord::Migration[6.1]
  def change
    add_column :seats, :state, :string, default: 'vacant'
  end
end
