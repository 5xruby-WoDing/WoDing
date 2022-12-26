class RemoveNameColumnFormOpening < ActiveRecord::Migration[6.1]
  def change
    remove_column :opening_times, :title
  end
end
