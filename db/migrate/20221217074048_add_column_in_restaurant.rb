class AddColumnInRestaurant < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :dining_time, :integer, default: 0
  end
end
