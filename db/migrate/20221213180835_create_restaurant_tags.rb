# frozen_string_literal: true

class CreateRestaurantTags < ActiveRecord::Migration[6.1]
  def change
    create_table :restaurant_tags do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
