class AddDefaultTimeOnIntervalColumn < ActiveRecord::Migration[6.1]
  def change
    change_column :restaurants, :interval_time, :integer, default: 15
  end
end
