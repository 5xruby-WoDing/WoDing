class CreateOffDays < ActiveRecord::Migration[6.1]
  def change
    create_table :off_days do |t|
      t.string :off_day
      t.belongs_to :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
