class AddColumnIntevalTimeInResataurant < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :interval_time, :integer, default: 15
  end
end
