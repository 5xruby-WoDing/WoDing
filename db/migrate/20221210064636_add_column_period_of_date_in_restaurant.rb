class AddColumnPeriodOfDateInRestaurant < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :period_of_reservation, :integer, default: 1
  end
end
