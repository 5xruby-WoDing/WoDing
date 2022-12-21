# frozen_string_literal: true

class AddCloumnBranchInRestaurantModel < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :branch, :string, default: ''
  end
end
