class RemoveColumnFromRestaurant < ActiveRecord::Migration[6.1]
  def change
    remove_column :restaurants, :start_time
    remove_column :restaurants, :end_time
  end
end
