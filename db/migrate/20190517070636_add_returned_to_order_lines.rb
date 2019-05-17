class AddReturnedToOrderLines < ActiveRecord::Migration[5.2]
  def change
    add_column :order_lines, :returned, :boolean
  end
end
