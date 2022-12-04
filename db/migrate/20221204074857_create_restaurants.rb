class CreateRestaurants < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurants do |t|
      t.string :title
      t.string :tel
      t.string :address
      t.datetime :deleted_at, default: nil
      t.belongs_to :manager, null: false, foreign_key: true

      t.timestamps
    end
    add_index :restaurants, :deleted_at
  end
end
