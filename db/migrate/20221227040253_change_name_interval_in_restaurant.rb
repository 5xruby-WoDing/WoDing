class ChangeNameIntervalInRestaurant < ActiveRecord::Migration[6.1]
  def change
    remove_column :restaurants, :intreval_time
    add_column :restaurants, :interval_time, :integer
  end
end
