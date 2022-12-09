class CreateOpeningTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :opening_times do |t|
      t.time :start_time
      t.time :end_time
      t.belongs_to :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
