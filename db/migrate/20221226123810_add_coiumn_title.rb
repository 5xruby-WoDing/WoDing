class AddCoiumnTitle < ActiveRecord::Migration[6.1]
  def change
    add_column :seats, :title, :string, default: '0'
  end
end
