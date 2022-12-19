class CreateManagerReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :manager_reservations do |t|
      t.references :manager, null: false, foreign_key: true
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
