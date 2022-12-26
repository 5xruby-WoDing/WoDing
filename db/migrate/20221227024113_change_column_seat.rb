class ChangeColumnSeat < ActiveRecord::Migration[6.1]
  def change
    change_column :seats, :title ,:string, default: '1'
  end
end
